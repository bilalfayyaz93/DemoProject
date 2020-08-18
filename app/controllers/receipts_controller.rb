class ReceiptsController < ApplicationController
  before_action :authenticate_user!

  def show
    @cart       = current_user.cart
    @line_items = @cart.line_items
  end
end
