class StripeWebhooksController < ApplicationController # :nodoc:
  # protect_from_forgery except: :receive
  # skip_before_action :authenticate_user!, only: :receive
  # skip_before_action :authenticate_account!, only: :receive

  # def receive
  #   skip_authorization

  #   begin
  #     event = construct_stripe_event(request)
  #   rescue JSON::ParserError, Stripe::SignatureVerificationError => error
  #     Rails.logger.error(error)
  #     # Invalid payload, invalid signature
  #     head(400)
  #     return
  #   end

  #   StripeWebhooksHandler.new(event).call

  #   head(200)
  # end

  # private

  # This allows to validate that the events were sent by Stripe, not by a third party.
  # def construct_stripe_event(request)
  #   signing_secret = Rails.application.secrets.stripe_webhooks_signing_secret
  #   payload = request.body.read
  #   sig_header = request.env['HTTP_STRIPE_SIGNATURE']

  #   Stripe::Webhook.construct_event(payload, sig_header, signing_secret)
  # end
end