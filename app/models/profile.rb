class Profile < ApplicationRecord


  belongs_to :user
  
  validate :has_valid_user


private

  def has_valid_user
    errors.add(:profile, "must belong to a valid user") if user == nil
  end


end
