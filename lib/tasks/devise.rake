namespace :devise do
  desc "Send reset password to on user.
  This will lockout the user until it reset its password."
  task send_welcome_reset_password_instructions_to_all_users: :environment do
    User.take(1).each do |user|
        # Send instructions so user can enter a new password:
        UserMailer.welcome_reset_password_instructions(user).deliver
        p user.id
      end
   end
end