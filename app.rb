class App <
  Roda
  %w[config services models].each { |dir| Unreloader.require(dir) {} }

  plugin :hash_branch_view_subdir
  plugin :empty_root
  plugin :render, layout: './layout', escape: true
  plugin :public
  plugin :partials
  plugin :route_csrf
  plugin :flash
  plugin :sessions,
         key: '_QNA.session',
         cookie_options: { secure: Settings.env == 'production' },
         secret: Settings.session_secret.to_s

  Unreloader.require('routes', delete_hook: proc { |f| hash_branch(File.basename(f).split('_').first) }) {}

  def current_user
    @current_user ||= User.first(id: session['user_id'])
  end

  def logged_in?
    !session['user_id'].nil?
  end

  def login_user(user)
    session['user_id'] = user.id
  end

  def logout_user
    session.delete('user_id')
  end

  # Helper method to safely subset parameters
  # with whitelisted attributes
  def sanitize_params(prefix, allowed_params)
    @_request.params[prefix].slice(*allowed_params)
  end

  route do |r|
    r.public
    check_csrf!
    r.hash_branches

    r.root do
      @recent_questions = DataAccess::Questions::Recent.call.questions
      view 'index'
    end
  end
end
