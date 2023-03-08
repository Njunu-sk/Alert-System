require 'rails_helper'

RSpec.describe "Alerts", type: :request do
  describe "POST /create" do
    let(:valid_attributes) do
      {
        alert: {
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
          type: "invalid",
          title: "invalid Alert",
          description: "An invalid alert was created",
          origin: "123.89.00.2",
          tags: ["versions2.3.9", "production"]
        }
      }
    end

    context "with valid attributes" do
      it "creates a new alert" do
        expect {
          post "/alerts", params: valid_attributes.to_json, headers: { "CONTENT_TYPE" => "application/json" }
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
        expect(JSON.parse(response.body)).to eq({ "error" => "Invalid alert type" })
      end
    end
  end
end
