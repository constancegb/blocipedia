class DowngradeController < ApplicationController
   def new
   end

   def create
     current_user.standard!
     current_user.wikis.update_all!(private: false)
     flash[:notice] = "You have successfully downgraded your account"
     redirect_to root_path
   end
 end
