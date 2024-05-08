class OrderMailerPreview < ActionMailer::Preview
  def order_placed_email
    @order = Order.last
    OrderMailer.with(order: @order).order_placed_email
  end
end