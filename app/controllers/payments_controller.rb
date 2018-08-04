class PaymentsController < ApplicationController
  before_action :set_loan

  def create
    @loan.payments.create!(payment_params)
    render json: @loan, status: :created
  end

  private

  def set_loan
    @loan = Loan.find(params[:loan_id])
  end

  def payment_params
    params.permit(:amount)
  end

end
