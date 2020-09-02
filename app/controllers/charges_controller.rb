class ChargesController < ApplicationController
  def new
    @amount = (session[:total_price]*100).to_i
  end

  def create
    amount = (session[:total_price]*100).to_i
    Payment::ChargeService.new(amount, params[:stripeEmail], params[:stripeToken]).call!

    redirect_to new_order_path
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end
end
