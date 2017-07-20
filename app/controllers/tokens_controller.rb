require 'exponent-server-sdk'

class TokensController < ApplicationController

  def create
    message = ''

    # You probably actually want to associate this with a user,
    # otherwise it's not particularly useful
    @token = Token.where(value: params[:token][:value]).first

    if @token.present?
      message = 'Welcome back!'
    else
      @token = Token.create(token_params)
      message = 'Hello there! This is a push notification.'
    end

    exponent.publish(
      exponentPushToken: @token.value,
      message: message,
      data: {a: 'b'}, # Any arbitrary data to include with the notification
    )

    render json: {success: true}
  end

  private

  def token_params
    params.require(:token).permit(:value)
  end

  def exponent
    @exponent ||= Exponent::Push::Client.new
  end

end
