class User < ApplicationRecord
  # include HTTParty

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :validatable, :omniauthable, omniauth_providers: [:line]

  belongs_to :organization, optional: true
  has_many :daily_reports
  has_one :today_daily_report, -> { where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day) },
          class_name: 'DailyReport'
  has_many :healthy_trackings
  has_one :today_healthy_tracking, -> { where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day) },
          class_name: 'HealthyTracking'
  has_many :org_daily_reports, class_name: 'DailyReports', through: :organization

  # 業務 總公司職員 總公司部門經理 單位行政
  enum role: { sales: 0, staff: 1, manager: 2, sales_supervisor: 3 }

  validates :real_name, presence: { message: '請輸入姓名' }, on: :update
  validates :eno, presence: { message: '請輸入業代' }, on: :update
  validates :organization_id, presence: { message: '請選擇部門' }, on: :update
  validates :role, presence: { message: '請選擇一個選項' }, on: :update
  validate :validate_eno, on: :update

  before_commit :check_daily_report_eno

  def check_daily_report_eno
    organization && organization.daily_reports.where(eno: eno).update_all(user_id: id)
  end

  def self.from_omniauth(auth)
    if auth.provider == 'line'
      user = User.find_or_create_by(line_id: auth.uid)
      user.name = auth.info.name
      user.save(validate: false)
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
      user.name = name
      user.image_url = image_url
      user.save(validate: false)
      user
    end
  end

  def role_name
    {
      sales: '業務員',
      staff: '公司同仁',
      manager: '負責主管',
      sales_supervisor: '單位行政'
    }[role&.to_sym]
  end

  def email_required?
    false
  end

  def password_required?
    false
  end

  def registered?
    real_name.present? && eno.present? && organization.present?
  end

  def need_tracking?
    daily_reports.where('need_tracking_till > ?', Date.today).present?
  end

  def send_daily_report_notify
    return if today_daily_report.present?

    self.class.client.push_message(line_id, {
                                     type: 'text',
                                     text: "Hi,#{name}. \n提醒您，今日尚未填寫每日足跡回報喔!!"
                                   })
  end

  private

  def validate_eno
    return unless eno_changed?

    response = HTTParty.post(ENV['ENO_API'], body: "eno=#{eno}",
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
