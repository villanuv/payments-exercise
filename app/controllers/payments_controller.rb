class PaymentsController < ApplicationController
  before_action :set_loan

  def create
    if params[:amount].to_f <= @loan.funded_amount && params[:amount].to_f > 0
      @loan.payments.create!(payment_params)
      render json: @loan, status: :created
    else
      render json: @loan.errors, status: :unprocessable_entity
    end
  end

  private

  def set_loan
    @loan = Loan.find(params[:loan_id])
  end

  def payment_params
    params.permit(:amount)
  end

end
