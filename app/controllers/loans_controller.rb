class LoansController < ActionController::API

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: 'not_found', status: :not_found
  end

  def index
    render json: Loan.all
  end

  def show
    render json: Loan.find(params[:id]), include: 'payments'
  end

  def update
    Loan.find(params[:id]).update(loan_params)
    head :no_content
  end

  private

  def loan_params
    params.permit(:funded_amount)
  end

end
