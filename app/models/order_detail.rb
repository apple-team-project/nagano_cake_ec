class OrderDetail < ApplicationRecord
  enum making_status: { start_not_possible: 0, make_pending: 1, making: 2, make_complete: 3 }
end
