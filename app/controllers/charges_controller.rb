class ChargesController < ApplicationController
  def new
    @amount = (session[:total_price].to_f*100).to_i
  end

  def create
    # Amount in cents
    @amount = (session[:total_price].to_f*100).to_i

    service = Payment::ChargeService.new(@amount, params)
    if service.call!
      redirect_to new_order_path
    else

    end

    rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end
end
