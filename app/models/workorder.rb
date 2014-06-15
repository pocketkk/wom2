class Workorder < ActiveRecord::Base

  validates :customer, presence: true
  validates :address, presence: true
  validates :phone, presence: true

  belongs_to :user

end
