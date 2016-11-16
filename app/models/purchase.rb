# == Schema Information
#
# Table name: purchases
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  product_id :integer
#  price      :decimal(, )
#  status     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Purchase < ApplicationRecord
  belongs_to :user
  belongs_to :product

  #enum
  enum status:[:pending, :paid]
#Class method to get the number of purchses
  def self.number_of_purchases(user, status)
    if status == "pending"
      user.purchases.where(status: :pending).count
    elsif status == "paid"
      user.purchases.where(status: :paid).count
    else
      -1
    end
  end
#Class to get the total debt
  def self.balance(user)
    pending_purchases = user.purchases.where(status: :pending)
    pending_purchases.size > 0 ? user.purchases.where(status: :pending).sum(&:price) : 0
  end

end
