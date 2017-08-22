class UsersController < Clearance::UsersController
  def new
    @user = user_from_params
  end

  def create
    @user = user_from_params
    if @user.save
      sign_in @user
      @user.customer!
      redirect_back_or url_after_create
    else
      render template: "users/new"
    end
  end

  def show
    @user = current_user
    @listing = Listing.where(user_id: @user.id)
  end

  def moderator
    @user = User.find(current_user.id)
    if @user.name == "Tan Ga Foo"
      @user.moderator!
      flash[:notice] = "You are successfully a moderator!"
    else
      flash[:notice] = "Sorry, you are not allowed to become a moderator"
    end
    redirect_to 'show'
  end

  private

  def user_from_params
    name = user_params.delete(:name)
    country = user_params.delete(:country)
    email = user_params.delete(:email)
    password = user_params.delete(:password)
    avatar = user_params.delete(:avatar)
    remote_avatar_url = user_params.delete(:remote_avatar_url)

    Clearance.configuration.user_model.new(user_params).tap do |user|
      user.name = name
      user.country = country
      user.email = email
      user.password = password
      user.avatar = avatar
      user.remote_avatar_url = remote_avatar_url
    end
  end
end
