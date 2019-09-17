Rails.configuration.stripe = {
  :publishable_key => 'pk_test_5w2QiT8pnzcLSzxyDBpNNdCA00SSc6AoX7',
  :secret_key      => 'sk_test_sczHYDHVIYPbTUkOJpjYLou600UJtH5Gev'
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]