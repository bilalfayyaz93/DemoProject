module Payment
  class ChargeService
    def initialize(amount, email, token)
      @amount = amount
      @stripe_email  = email
      @stripe_token  = token
    end

    def call!
      charge_payment!
    end

    private
      def charge_payment!
        customer = Stripe::Customer.create({
        email: @stripe_email,
        source: @stripe_token,})

        charge = Stripe::Charge.create({
          customer: customer.id,
          amount: @amount,
          description: 'Rails Stripe customer',
          currency: 'usd',
        })

      end
  end
end
