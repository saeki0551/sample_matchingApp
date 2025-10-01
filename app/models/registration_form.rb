class RegistrationForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attr_accessor :user_attributes, :user_information_attributes

  def save
    return false if invalid?

    ActiveRecord::Base.transaction do
      save!
    end
    true
  rescue ActiveRecord::RecordInvalid
    false
  end

  def user
    @user = User.new(user_attributes)
  end

  def user_information
    @user_information = UserInformation.new(user_information_attributes)
  end

end