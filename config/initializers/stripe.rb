Stripe.api_key = "sk_test_51HD8DJBKQ0RylwgbcHr0sfcCVohDHVfOwawstomctY90zYfhq69eDbhJDctKZYEHrswwvwZ7y10BRxN7jav6Jhx500gwIcqqLN"
STRIPE_PUBLIC_KEY = "pk_test_51HD8DJBKQ0RylwgbRtRqQqFB4yzpxvdyBaAe2IDxUGMklfSdt6w0OCfTJufrH0UormFZRuZFKoYdBRV4bFyRyJfy00ZsVfuL3R"
Rails.configuration.stripe = {
  :publishable_key => ENV['PUBLISHABLE_KEY'],
  :secret_key      => ENV['SECRET_KEY']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
