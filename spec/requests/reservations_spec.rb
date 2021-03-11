require 'rails_helper'

RSpec.describe "Reservations", type: :request do
  describe "GET /reservations" do
    it "returns http success" do
      get "/reservations"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /reservations" do
    subject do
      post "/reservations", params: payload,
                            headers: { 
                              'CONTENT_TYPE' => 'application/json', 
                              'ACCEPT' => 'application/json'
                            }
      response
    end

    context "without payload" do
      let(:payload) { '' }
      it { should have_http_status(:unprocessable_entity) }
    end

    context 'with Service Payload Format 1' do
      let(:payload) { file_fixture('format1.json').read }

      it "returns http success" do
        expect { should have_http_status(:success) }
          .to change(Reservation, :count)
      end
    end

    context 'with Service Payload Format 2' do
      let(:payload) { file_fixture('format2.json').read }

      it "returns http success" do
        expect { should have_http_status(:success) }
          .to change(Reservation, :count)
      end
    end
  end
end
