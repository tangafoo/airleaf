class UsersController < Clearance::UsersController
  def new
    @user = user_from_params
  end

  def show
    @user = current_user
    @listing = Listing.where(user_id: @user.id)
  end

  private

  def user_from_params
    name = user_params.delete(:name)
    country = user_params.delete(:country)
    email = user_params.delete(:email)
    password = user_params.delete(:password)

    Clearance.configuration.user_model.new(user_params).tap do |user|
      user.name = name
      user.country = country
      user.email = email
      user.password = password
    end
  end
end
