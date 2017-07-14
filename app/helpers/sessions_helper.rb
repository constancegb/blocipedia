module SessionsHelper

  def create_session(user)
     session[:user_id] = user.id
   end

   def destroy_session(user)
     session[:user_id] = nil
   end

    # def current_user #already defined in devise
    #   User.find_by(id: session[:user_id])
    #   # current_user is a shortcut to this functionality
    # end



end
