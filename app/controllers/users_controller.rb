# encoding: utf-8

class UsersController < ApplicationController

  before_action :signed_in_user, :only => [:index,:edit, :update, :destroy, :following, :followers]
  before_action :correct_user ,  :only => [:edit, :update]
  
def index
    @users = User.all
end
def edit
  @user = User.find(params[:id])
end
 
 def update
  @user = User.find(params[:id])
  if @user.update_attributes(user_params)
    flash[:success] = "Profil actualisé."
      redirect_to @user
  else
    render 'edit'
  end
   
 end

  def new
  	@user = User.new
  end
  
  def show
  	@user = User.find(params[:id])	
    @microposts = @user.microposts.paginate(page: params[:page])
  end

def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end


  def destroy
     User.find(params[:id]).destroy    
    flash[:success] = "User deleted."
    redirect_to users_url
  end

def following 
  @title = "Following"
  @user = User.find(params[:id])
  @users = @user.followed_users.paginate(page: params[:page])
  render 'show_follow'
end

def followers
  @title = "followers"
  @user = User.find(params[:id])
  @users = @user.followers.paginate(page: params[:id])
  render 'show_follow'
  
end


  private 
  def user_params
  	params.require(:user).permit(:name, :email, :password, :password_confirmation)
  	
  end
#def signed_in_user
 # redirect_to signin_url, :notice => "Please sign in " unless signed_in? 
#end
 def correct_user
   @user = User.find(params[:id])
   redirect_to(root_url) unless current_user?(@user)
 end



 end
