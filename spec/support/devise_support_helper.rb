module DeviseSupportHelper
	def sign_in_as_valid_user
		@user ||= FactoryGirl.create :user

		post_via_redirect user_session_path, 'user[:email]' => @user.email, 'user[password]' => @user.password
	end
end

# RSpec.configure do |config|
# 	config.include DeviseSupport, type: :request
# end