module Payment
  class ChargeService
    def initialize(amount, params)
      @amount = amount
      @params = params
    end

    def call!
      charge_payment!
    end

    private
      def charge_payment!
        customer = Stripe::Customer.create({
        email: @params[:stripeEmail],
        source: @params[:stripeToken],})

        charge = Stripe::Charge.create({
          customer: customer.id,
          amount: @amount,
          description: 'Rails Stripe customer',
          currency: 'usd',
        })
      end
  end
end
