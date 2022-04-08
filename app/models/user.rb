class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :validatable, :omniauthable, omniauth_providers: [:line]

  belongs_to :organization, optional: true
  before_save :set_default_righ_menu

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
      line_id = params.dig(:source_user_id)
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

  private

  def set_default_righ_menu
    client = Line::Bot::Client.new do |config|
      config.channel_secret = ENV['LINE_CHANNEL_SECRET']
      config.channel_token = ENV['LINE_CHANNEL_TOKEN']
    end

    if real_name.nil? && organization.nil? && eno.nil?
      client.link_user_rich_menu(line_id, 'richmenu-cc832d0f455ccfc761be8c4c075f2185')
    end
  end
end
