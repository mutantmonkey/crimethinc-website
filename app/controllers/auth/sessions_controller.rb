class Auth::SessionsController < Admin::AdminController
  layout "admin"

  # /signin
  def new
    @page_title = "Sign In"
    @body_id = "signin"
    # TODO: why doesn't this prevent a signed in user going to /signin
    return redirect_to(root_url) if signed_in?
  end

  # /signin
  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to admin_path, notice: "Logged in!"
    else
      flash.now.alert = "Invalid username or password"
      render "new"
    end
  end

  # /signout
  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Signed out!"
  end
end
