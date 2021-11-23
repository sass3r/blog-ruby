class SubscriberController < ApplicationController
    def create
      @subscriber = Subscriber.new(subscriber_params)
      @subscribers = Subscriber.all
      @registered = false
      mail = @subscriber.email
      exist_mail = @subscribers.where(email: mail)
      size = exist_mail.size
      if size == 0
        @subscriber.save
        @registered = true
        SubscriberMailer.with(subscriber: @subscriber).welcome_email.deliver_now
      end
    end

    def subscriber_params
      params.permit(:email)
    end
end
