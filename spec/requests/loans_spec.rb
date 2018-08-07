require 'rails_helper'

RSpec.describe 'Loans API', type: :request do

  let!(:loans) { create_list(:loan, 10) }
  let(:loan) { loans.first }
  let(:loan_id) { loans.first.id }

  describe "GET /loans" do
    before { get "/loans" }

    it "returns all loans" do
      expect(json).not_to be_empty
      expect(json.size).to eq 10
    end

    it "returns status code 200" do
      expect(response).to have_http_status 200
    end
  end

  describe "GET /loans/:id" do
    before { get "/loans/#{loan_id}" }

    context "when loan exists" do
      it "returns the loan" do
        expect(json).not_to be_empty
        expect(json['id']).to eq loan_id
      end

      it "returns status code 200" do
        expect(response).to have_http_status 200
      end
    end

    context "when loan does not exist" do
      let(:loan_id) { 100 }

      it "returns status code 404" do
        expect(response).to have_http_status 404
      end

      it "returns not found" do
        expect(response.body).to eq "not_found"
      end
    end
  end

end