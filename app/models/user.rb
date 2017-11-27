class User < ApplicationRecord
	has_secure_password

	has_many :user_roles
	has_many :roles, through: :user_roles


	def role?(role)
		roles.any? { |r| r.name.underscore.to_sym == role }
	end

end
