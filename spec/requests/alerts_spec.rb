require 'rails_helper'

RSpec.describe "Alerts", type: :request do
  let!(:user) { User.create(name: "user1", email: "user1@gmail.com", password: "password") }
  let!(:alert1) { Alert.create(type: "portal_opened", title: "Alert 1", user_id: user.id) }
  let!(:alert2) { Alert.create(type: "portal_closed", title: "Alert 2", user_id: user.id) }
  
  let(:valid_attributes) do
    {
      alert: {
        user_id: user.id,
        type: "portal_opened",
        title: "Portal Opened",
        description: "A portal was opened",
        origin: "123.89.00.2",
        tags: ["versions2.3.9", "production"]
      }
    }
  end

  let(:invalid_attributes) do
    {
      alert: {
        user_id: user.id,
        type: "invalid",
        title: "invalid Alert",
        description: "An invalid alert was created",
        origin: "123.89.00.2",
        tags: ["versions2.3.9", "production"]
      }
    }
  end

  describe "POST /create" do
    context "with valid attributes" do
      it "creates a new alert" do
        expect {
          post "/alerts", params: valid_attributes.to_json, headers: valid_headers
        }.to change(Alert, :count).by(1)

        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end

    context "with invalid attributes" do
      it "returns an error message" do
        post "/alerts", params: invalid_attributes.to_json,  headers: { "CONTENT_TYPE" => "application/json" }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(JSON.parse(response.body)).to eq({"message"=>"Missing token"})
      end
    end
  end

  describe "GET /index" do
    context "when they are alerts in the database" do
      it "returns a JSON response with all the alerts" do
        get "/alerts"
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['alerts'].count).to eq(2)
      end
    end

    context "when there are no alerts in the database" do
      before { Alert.delete_all }

      it "retuns an empty JSON reponse" do
        get "/alerts"
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['alerts'].count).to eq(0)
      end
    end
  end
end
