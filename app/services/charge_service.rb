  class ChargeService
    def initialize(amount)
      @amount = amount
    end

    def call!
      charge_payment!
    end

    private
      def charge_payment!
        customer = Stripe::Customer.create({
        email: current_user.email,
        source: params[:stripeToken],})

        charge = Stripe::Charge.create({
          customer: customer.id,
          amount: @amount,
          description: 'Rails Stripe customer',
          currency: 'usd',
        })
      end
  end
