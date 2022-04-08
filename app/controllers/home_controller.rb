class HomeController < ApplicationController
  include Kamigo::Clients::LineClient

  def index; end

  def member_join
    @profiles = params.dig(:payload, :joined, :members).map { |member| get_profile(member.dig(:userId)) }
  end

  def member_; end
end
