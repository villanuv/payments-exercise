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
    payment = @loan.payments.new(payment_params)
    if payment.valid?
      payment.save
      loan_update
      render json: payment, status: :created
    else
      render json: payment.errors, status: :unprocessable_entity
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

  def loan_update
    balance = @loan.funded_amount - params[:amount].to_f
    @loan.update_attributes({ funded_amount: balance })
  end

end
