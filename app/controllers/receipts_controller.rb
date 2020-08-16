class ReceiptsController < ApplicationController
  before_action :authenticate_user!

  def index
    @cart       = current_user.cart
    @line_items = @cart.line_items
  end
end
