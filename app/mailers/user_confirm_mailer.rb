class UserConfirmMailer < ApplicationMailer
	default from: "buckrivard@gmail.com"

	def new_user(user)
		@user = user

		mail(to: user.email, subject: "Confirm your account")
	end
end
