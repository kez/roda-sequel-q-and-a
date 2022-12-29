class App < Roda
  hash_branch 'users' do |r|

    r.is 'logout' do
      logout_user
      flash[:success] = "Logged out!"
      r.redirect '/'
    end

    r.is 'login' do
      r.get do
        @title = "Login to #{Settings.name}"
        @dummy_emails = (1..3).to_a.map{|user_prefix| "user#{user_prefix}@localhost.dev"}
        view 'login'
      end

      r.post do
        params = sanitize_params('user', %w[email password_raw_input])
        user = DataAccess::Users::ByEmailForLogin.call(email: params['email']).user

        if user.nil?
          flash[:error] = "That user could not be logged in"
          r.redirect "/users/login" and return
        end

        login_user(user)

        flash[:success] = "Logged in!"
        r.redirect '/'
      end
    end
  end
end
