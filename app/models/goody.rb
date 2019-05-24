# -*- coding: utf-8 -*-
class Goody < ApplicationRecord
  # Add relation, but also allow non-active campaigns to already
  # create goodies
  belongs_to :campaign, -> { unscope(where: 'active') }
  has_many :orders
  has_many :supporters, through: :orders
  has_one :goody_image

  validates :price, numericality: true, presence: true
  validates :quantity, numericality: true, presence: true

  accepts_nested_attributes_for :goody_image, update_only: true
  def orders_count
    orders.where(:status => 3).count
  end

  def input_goody_image
    self.goody_image ||= self.build_goody_image
  end

  def remaining_quantity
    if quantity != -1
      quantity - orders_count
    else
      '∞'
    end
  end

end
