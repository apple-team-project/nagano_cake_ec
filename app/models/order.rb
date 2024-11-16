class Order < ApplicationRecord
  enum payment_method: { credit_card: 0, cash: 1 }
  enum status: { payment_waiting: 0, payment_confirmation: 1, making: 2, delivery_preparation: 3, delivered: 4 }
end
