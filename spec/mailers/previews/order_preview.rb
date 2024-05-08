# Preview all emails at http://localhost:3000/rails/mailers/order
class OrderPreview < ActionMailer::Preview
  def order_placed_email
    @order = Order.first
    @line_items = @order.line_items
    @products = @line_items.reduce([]) do |array, item| 
      array << item.product
      array
    end
    OrderMailer.with(order: @order, products: @products).order_placed_email
  end
end
