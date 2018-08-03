require 'rails_helper'

RSpec.describe PaymentsController, type: :controller do
  @loan = Loan.create!(funded_amount: 100.0)
  @loan.payments.create!(amount: 10.0)
  p @loan

  describe "PUT #create" do
    it "returns http success" do
      get :create
      expect(response).to have_http_status(:success)
    end
  end

end
