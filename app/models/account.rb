class Account < ApplicationRecord
  validates :token, :platform_name, :uid, presence: true

end
