class UserAuthenticationController < ApplicationController
  # Uncomment line 3 in this file and line 5 in ApplicationController if you want to force users to sign in before any other actions.
  # skip_before_action(:force_user_sign_in, { :only => [:sign_up_form, :create, :sign_in_form, :create_cookie] })
  
  def welcome_page
    if session.fetch(:user_id) == nil
      render({ :template => "user_authentication/welcome.html.erb" })
     else 
      redirect_to("/ootd", { :notice => "welcome back" })
    end
  end
  #redirect_to("/feed", { :notice => "Signed in successfully." })
  def sign_in_form
    render({ :template => "user_authentication/sign_in.html.erb" })
  end

  def create_cookie
    user = User.where({ :email => params.fetch("query_email") }).first
    
    the_supplied_password = params.fetch("query_password")
    
    if user != nil
      are_they_legit = user.authenticate(the_supplied_password)
    
      if are_they_legit == false
        redirect_to("/user_sign_in", { :alert => "Incorrect password." })
      else
        session[:user_id] = user.id
      
        redirect_to("/ootd", { :notice => "Signed in successfully." })
      end
    else
      redirect_to("/user_sign_in", { :alert => "No user with that email address." })
    end
  end

  def destroy_cookies
    reset_session

    redirect_to("/", { :notice => "Signed out successfully." })
  end

  def sign_up_form
    render({ :template => "user_authentication/sign_up.html.erb" })
  end
  #made the decision to default new users to a public account. The user can make their account private if they chose by visiting the setting page and edit account. 
  def create
    @user = User.new
    @user.email = params.fetch("query_email")
    @user.password = params.fetch("query_password")
    @user.password_confirmation = params.fetch("query_password_confirmation")
    @user.username = params.fetch("query_username")
    @user.mobile = params.fetch("query_mobile")
    @user.user_profile_pic = params.fetch("query_user_profile_pic")
    @user.sent_follow_requests_count = 0
    @user.received_follow_requests_count = 0
    @user.own_photos_count = 0
    save_status = @user.save

    if save_status == true
      session[:user_id] = @user.id
   
      redirect_to("/ootd", { :notice => "User account created successfully."})
      
    else
      redirect_to("/user_sign_up", { :alert => @user.errors.full_messages.to_sentence })
    end
  end
    
  def edit_profile_form
    render({ :template => "user_authentication/edit_profile.html.erb" })
  end

  def update
    @user = @current_user
    @user.email = params.fetch("query_email")
    @user.password = params.fetch("query_password")
    @user.password_confirmation = params.fetch("query_password_confirmation")
    @user.private = params.fetch("query_private")
    @user.username = params.fetch("query_username")
    @user.mobile = params.fetch("query_mobile")
    @user.user_profile_pic = params.fetch("query_user_profile_pic")

    
    if @user.valid?
      @user.save

      redirect_to("/", { :notice => "User account updated successfully."})
    else
      render({ :template => "user_authentication/edit_profile_with_errors.html.erb" , :alert => @user.errors.full_messages.to_sentence })
    end
  end

  def destroy
    @current_user.destroy
    reset_session
    redirect_to("/", { :notice => "User account cancelled" })
  end
  
  def settings
  render({ :template => "user_authentication/settings.html.erb"})
  end

  # def search
  #   render({ :template => "user_authentication/search.html.erb"})
  # end

  def search_results
   @searching = User.all
    if params[:search_by_username] && params[:search_by_username] != ""
    @search_resulting = @searching.where("username like ?", "%# {params[:search_by_username]}%")
  end
 
   render({ :template => "user_authentication/search.html.erb"})
  end
  def directory
    @user_list = User.all
    render({ :template => "user_authentication/directory.html.erb"})
  end 
end
