class UsersController < ApplicationController
  skip_before_action :authorized, only: [:new, :create]

  def home
    @user = current_user
    @comments = current_user.get_user_groups_parent_comments
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      @user.save
      session[:user_id] = @user.id
      redirect_to home_path
    else
      flash[:error] = @user.errors.full_messages
      redirect_to signup_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :picture)
  end

end
