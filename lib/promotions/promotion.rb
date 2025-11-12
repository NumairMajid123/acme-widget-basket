# frozen_string_literal: true

class Promotion
  def apply_discount(basket_items)
    raise NotImplementedError, 'must be implemented by subclass'
  end
end

