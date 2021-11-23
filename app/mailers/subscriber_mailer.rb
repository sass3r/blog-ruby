class SubscriberMailer < ApplicationMailer
  def welcome_email
    @subscriber = params[:subscriber]
    @url = 'https://www.devsec.ml'
    #delivery_options = { user_name: params[:company].smtp_user,
    #                     password: params[:company].smtp_password,
    #                     address: params[:company].smtp_host
    #}
    mail(to: @subscriber.email, subject: 'Welcome to My Awesome Site')
  end
end
