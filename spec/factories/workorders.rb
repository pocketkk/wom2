# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :customer do |n|
    "Customer #{n}"
  end
  sequence :address do |n|
    "1234#{n} 1st St"
  end

  factory :workorder do
    customer
    address
    phone 5554527867
    user
  end

end
