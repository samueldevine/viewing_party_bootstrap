class UsersController < ApplicationController
  def login
  end

  def login_check
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      flash[:success] = 'Successfully logged in'
      redirect_to "/users/#{user.id}"
    else
      flash[:warning] = 'Invalid username or password'
      redirect_to '/login'
    end
  end

  def dashboard
    @user = User.find(params[:id])
    viewing_parties = ViewingParty.find_by_user(@user)
    if viewing_parties != []
      @party_details = MovieFacade.party_details(viewing_parties)
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "Account successfully created"
      redirect_to "/users/#{@user.id}"
    else
      flash[:notice] = @user.errors.full_messages.to_sentence
      render :new
    end
  end

  def discover
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
