require 'rails_helper'

RSpec.describe 'Payments API', type: :request do

  let!(:loan) { create(:loan) }
  let(:payments) { create_list(:payment, 10, loan_id: loan.id) }
  let(:loan_id) { loan.id }
  let(:id) { payments.first.id }

  describe "POST /loans/:loan_id/payments" do
    let(:amount) { { amount: 10.0 } }

    context "when request attributes are valid" do
      before { post "/loans/#{loan_id}/payments", params: amount }

      it "returns status code of 201" do
        expect(response).to have_http_status 201
      end
    end

  end

end