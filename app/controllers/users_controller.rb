class UsersController < BaseController
  skip_before_action :require_login, only: %i[new create discover]

  def dashboard
    # @user = User.find(params[:id])
    viewing_parties = ViewingParty.find_by_user(current_user)
    @party_details = MovieFacade.party_details(viewing_parties) if viewing_parties != []
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)

    if user.save
      session[:user_id] = user.id
      flash[:success] = 'Account successfully created'
      redirect_to '/dashboard'
    else
      flash[:notice] = user.errors.full_messages.to_sentence
      render :new
    end
  end

  def discover
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
