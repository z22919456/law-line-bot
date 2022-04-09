class User < ApplicationRecord
  extend Kamigo::Clients::LineClient
  include HTTParty

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :validatable, :omniauthable, omniauth_providers: [:line]

  belongs_to :organization, optional: true
  has_many :daily_reports
  before_save :set_default_righ_menu

  LOGIN_RICH_MENU = 'richmenu-cc832d0f455ccfc761be8c4c075f2185'.freeze

  validates :real_name, presence: { message: '請輸入姓名' }, on: :update
  validates :eno, presence: { message: '請輸入業代' }, on: :update
  validates :organization_id, presence: { message: '請選擇部門' }, on: :update
  validate :validate_eno, on: :update

  def self.from_omniauth(auth)
    if auth.provider == 'line'
      user = User.find_or_create_by(line_id: auth.uid)
      user.update(name: auth.info.name)
      user
    end
  end

  # params[:source_user_id]
  # params[:profile][:displayName]
  def self.from_kamigo(params)
    if params[:profile].present? && params[:source_user_id].present?
      line_id = params[:source_user_id]
      name = params.dig(:profile, :displayName)
      image_url = params.dig(:profile, :pictureUrl)
      user = User.find_or_create_by(line_id: line_id)
      user.update(name: name, image_url: image_url)
      user
    end
  end

  def email_required?
    false
  end

  def password_required?
    false
  end

  def verify_user_data_setting
    real_name.present? && eno.present? && organization.present?
  end

  private

  def set_default_righ_menu
    self.class.client.link_user_rich_menu(line_id, LOGIN_RICH_MENU) if real_name.nil? && organization.nil? && eno.nil?
  end

  def validate_eno
    return unless eno_changed?

    response = self.class.post('https://www1uat.law888.com.tw/LawAP/ws/referee', body: "eno=#{eno}",
                                                                                 headers: { 'Content-Type' => 'application/x-www-form-urlencoded' })

    Rails.logger.debug '%%%%%%%%%%%%%%%%%%%%%%%%%%%%'
    Rails.logger.debug "response.body: #{response.body}"
    Rails.logger.debug errors.full_messages
    Rails.logger.debug '%%%%%%%%%%%%%%%%%%%%%%%%%%%%'

    result = JSON.parse(response.body)
    response_code = result['responseCode']
    errors.add :basic, result['responseMsg'] unless response_code == '00'
  rescue StandardError
    Rails.logger.error StandardError
    errors.add :basic, '業代認證API發生錯誤'
  end
end
