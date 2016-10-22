# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  name        :string
#  reference   :string
#  precio      :decimal(, )
#  quantity    :integer
#  brand       :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Product < ApplicationRecord
  validates :name, :reference, :precio, :quantity, :brand, presence: true
  validates :precio, numericality: true
  validates :quantity, numericality: { only_integer: true }
  validates :precio, :quantity, numericality: { greater_or_equal_to: 0 }
end
