require 'rails_helper'

RSpec.describe 'Payments API', type: :request do

  let!(:loan) { create(:loan) }
  let!(:payments) { create_list(:payment, 5, loan_id: loan.id) }
  let(:loan_id) { loan.id }
  let(:id) { payments.first.id }
  let(:amount) { { amount: "10.0" } }

  describe "GET /loans/:loan_id/payments" do
    before { get "/loans/#{loan_id}/payments" }

    context "when loan exists" do
      it "returns status code 200" do
        expect(response).to have_http_status 200
      end

      it "returns all loan payments" do
        expect(json.size).to eq 5
      end
    end

    context "when loan does not exist" do
      let(:loan_id) { 0 }

      it "returns status code 404" do
        expect(response).to have_http_status 404
      end

      it "returns not found" do
        expect(response.body).to eq "not_found"
      end
    end
  end

  describe "POST /loans/:loan_id/payments" do
    context "when request attributes are valid" do
      before { post "/loans/#{loan_id}/payments", params: amount }

      it "returns status code of 201 (created)" do
        expect(response).to have_http_status 201
      end

      it "updates @loan.funded_amount" do
        loan_funded_amt = loan.funded_amount
        loan_funded_amt_after_update = Loan.find(json['loan_id']).funded_amount
        expect(loan_funded_amt_after_update).to eq(loan_funded_amt - amount[:amount].to_f)
      end
    end

    context "when an invalid request: blank" do
      before { post "/loans/#{loan_id}/payments", params: {} }

      it "returns status code of 422" do
        expect(response).to have_http_status 422
      end

      it "returns the message can't be blank" do
        expect(json['amount']).to include "can't be blank"
      end
    end

    context "when an invalid request: not a number" do
      before { post "/loans/#{loan_id}/payments", params: { amount: 'x' } }

      it "returns status code of 422" do
        expect(response).to have_http_status 422
      end

      it "returns the message can't be blank" do
        expect(json['amount']).to include "is not a number"
      end
    end

    context "when an invalid request: amount exceeds loan" do
      before { post "/loans/#{loan_id}/payments", params: { amount: loan.funded_amount + 20 } }

      it "returns status code of 422" do
        expect(response).to have_http_status 422
      end

      it "returns the custom message" do
        expect(json['amount'][0]['message']).to include "payment cannot exceed loan.funded_amount"
      end

    end
  end

  describe "GET /loans/:loan_id/payments/:id" do
    before { get "/loans/#{loan_id}/payments/#{id}" }

    context "when loan payment exists" do
      it "returns status code 200" do
        expect(response).to have_http_status 200
      end

      it "returns the payment" do
        expect(json['id']).to eq id
      end
    end
  end

end