class ChargesController < ApplicationController
  def new
    @amount = (session[:total_price].to_f*100).to_i
  end

  def create
    # Amount in cents
    @amount = (session[:total_price].to_f*100).to_i

    Payment::ChargeService.new(@amount, params).call!

    redirect_to new_order_path
  rescue => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end
end
