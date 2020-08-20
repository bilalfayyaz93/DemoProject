Stripe.api_key =  Rails.application.credentials.stripe[:secret_key]
STRIPE_PUBLIC_KEY =  Rails.application.credentials.stripe[:public_key]
Rails.configuration.stripe = {
  :publishable_key => ENV['PUBLISHABLE_KEY'],
  :secret_key      => ENV['SECRET_KEY']
}
