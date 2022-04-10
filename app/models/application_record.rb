class ApplicationRecord < ActiveRecord::Base
  extend Kamigo::Clients::LineClient
  self.abstract_class = true
end
