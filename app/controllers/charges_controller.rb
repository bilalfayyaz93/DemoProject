class ChargesController < ApplicationController
  def new
    @amount = (session[:total_price].to_f*100).to_i
  end

  def create
    # Amount in cents
    @amount = (session[:total_price].to_f*100).to_i

    customer = Stripe::Customer.create({
      email: params[:stripeEmail],
      source: params[:stripeToken],
    })

    charge = Stripe::Charge.create({
      customer: customer.id,
      amount: @amount,
      description: 'Rails Stripe customer',
      currency: 'usd',
    })
    redirect_to new_order_path
    rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end
end
