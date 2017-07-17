include SessionsHelper
class WikisController < ApplicationController

  before_action :require_sign_in, except: [:index, :show]

  def index
    if current_user.standard?
       @public_wikis = Wiki.where(private: false)
     else
       @public_wikis = Wiki.where(private: false)
       @private_wikis = Wiki.where(private: true)
       # Look at incorporating Pundit
       # @wikis = (wikis.where(private: false)) + (current_user.wikis.where(private: true))
       # @wikis = Wiki.all
       # current_user.wikis.all <- all wikis belonging to the logged in user
     end
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def create
     @wiki = current_user.wikis.build
     @wiki.title = params[:wiki][:title]
     @wiki.body = params[:wiki][:body]
     @wiki.private = params[:wiki][:private]

     if @wiki.save
       flash[:notice] = "Wiki was saved."
       redirect_to @wiki
     else
       flash.now[:alert] = "There was an error saving the wiki. Please try again."
       render :new
     end
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def update
     @wiki = Wiki.find(params[:id])
     @wiki.title = params[:wiki][:title]
     @wiki.body = params[:wiki][:body]
     @wiki.private = params[:wiki][:private]

     if @wiki.save
       flash[:notice] = "Wiki was updated."
       redirect_to @wiki
     else
       flash.now[:alert] = "There was an error saving the wiki. Please try again."
       render :edit
     end
   end

   def destroy
     @wiki = Wiki.find(params[:id])
     if @wiki.destroy
       flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
       redirect_to wikis_path
     else
       flash.now[:alert] = "There was an error deleting the wiki."
       render :show
     end
   end

end
