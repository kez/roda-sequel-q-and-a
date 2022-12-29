# This class finds the first user with the email address
# passed in as an input.  The email address will be normalised to
# attempt to clean bad inputs.  This class should be extended to check for
# locked/closed accounts.
module DataAccess
  module Users
    class ByEmailForLogin < Actor
      fail_on ServiceActor::ArgumentError

      input :email, type: 'String'
      output :user

      def call
        # In the future, add more logic here to check for locked/closed accounts
        self.user = User.first(email: normalised_email)
      end

      private

      def normalised_email
        @normalised_email ||= email.to_s.strip.downcase
      end
    end
  end
end
