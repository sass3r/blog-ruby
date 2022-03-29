require 'securerandom'

class SubscriberController < ApplicationController
    def create
      @subscriber = Subscriber.new(subscriber_params)
      @subscribers = Subscriber.all
      @registered = false
      mail = @subscriber.email
      exist_mail = @subscribers.where(email: mail)
      size = exist_mail.size
      if size == 0
        @subscriber.register_token = SecureRandom.uuid
        @subscriber.confirmed = false
        @subscriber.save
        @registered = true
        SubscriberMailer.with(subscriber: @subscriber).welcome_email.deliver_now
      end
    end

    def subscriber_params
      params.permit(:email)
    end

    def verify
      if params[:token]
        @token = params[:token]
        @subscriber = Subscriber.find_by(register_token: @token)
        @subscriber.confirmed = true
        @subscriber.save
      end
    end
end
