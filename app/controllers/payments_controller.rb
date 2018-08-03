class PaymentsController < ApplicationController
  def create
    @payment = Payment.new(payment_params)
    if @payment.save
      render json: @payment.to_json
    else
      render json: @payment.errors
    end
  end

  private

  def payment_params
    params.require(:payment).permit(:amount)
  end
end
