class UsersController < ApplicationController

  def show
    @user = User.find_by!(username: params.fetch(:username))
  end

  def followers

  end

  def leaders

  end

end
