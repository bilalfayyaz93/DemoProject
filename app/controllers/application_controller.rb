class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_user_cart
  before_action :set_cart

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up,keys: [:name, :avator])
      devise_parameter_sanitizer.permit(:account_update,keys: [:name, :avator, :remove_avator])
    end

    def set_cart
      return if session[:cart_id]
      @cart = Cart.create
      session[:cart_id] = @cart.id
    end

    def set_user_cart
      return if session[:is_user_cart_set]

      if current_user
        session[:is_user_cart_set] = true
        session_cart = Cart.find(session[:cart_id])
        @cart = Cart.where(user_id: current_user.id).first

        if(@cart)
          return if(session_cart.id == @cart.id)

          session[:cart_id] = @cart.id
          session_cart.line_items.each do |item|
            line_item_in_user_cart = @cart.line_items.find_by(product_id: item.product_id)
            if line_item_in_user_cart
              line_item_in_user_cart.quantity += item.quantity
              line_item_in_user_cart.save
            else
              if Product.find(item.product_id).user_id != current_user.id
                @cart.line_items.create(quantity: item.quantity, product_id: item.product_id)
              end
            end
          end
        else
          session_cart.user_id = current_user.id
          current_user.cart = session_cart
        end
      end
    end
end
