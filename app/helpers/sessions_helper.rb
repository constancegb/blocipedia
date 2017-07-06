module SessionsHelper

  def create_session(user)
     session[:user_id] = user.id
   end

   def destroy_session(user)
     session[:user_id] = nil
   end

   def current_user
     User.find_by(id: session[:user_id]) # current_user is a shortcut to this functionality
   end

   private

   def require_sign_in #redirect un-signed-in users. Defined here because we'll call it from other controllers.
     unless current_user
       flash[:alert] = "You must be logged in to do that"
       redirect_to new_session_path
     end
   end

end
