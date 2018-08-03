require 'rails_helper'

RSpec.describe 'Loans API', type: :request do

  let!(:loans) { create_list(:loan, 10) }
  let(:loan_id) { loans.first.id }

  describe 'GET /loans' do
    before { get '/loans' }

    it 'returns loans' do
      expect(json).not_to be_empty
      expect(json.size).to eq 10
    end
  end

end