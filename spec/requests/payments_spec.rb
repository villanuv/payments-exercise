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
        funded_amount_response = json['funded_amount'].to_f
        manual_calculation = loan.funded_amount - amount[:amount].to_f
        expect(funded_amount_response).to eq(manual_calculation)
      end
    end

    context "when an invalid request" do
      before { post "/loans/#{loan_id}/payments", params: {} }

      it "returns status code of 422" do
        expect(response).to have_http_status 422
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