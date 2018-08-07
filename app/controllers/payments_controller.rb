class PaymentsController < ApplicationController
  before_action :set_loan
  before_action :set_loan_payment, only: [:show]

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: 'not_found', status: :not_found
  end

  def index
    render json: @loan.payments
  end

  def create
    if param_conditions
      @loan.payments.create!(payment_params)
      @loan.update({ funded_amount: @loan.funded_amount - params[:amount].to_f })
      render json: @loan, status: :created
    else
      render json: @loan.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: @payment
  end


  private

  def set_loan
    @loan = Loan.find(params[:loan_id])
  end

  def set_loan_payment
    @payment = @loan.payments.find_by!(id: params[:id]) if @loan
  end

  def payment_params
    params.permit(:amount)
  end

  def param_conditions
    params[:amount].to_f <= @loan.funded_amount && params[:amount].to_f > 0
  end

end
