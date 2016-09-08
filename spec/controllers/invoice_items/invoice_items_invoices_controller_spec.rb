require 'rails_helper'

RSpec.describe Api::V1::InvoiceItems::InvoicesController do
  describe "GET associated invoice" do
    it "retrieves the correct invoice for that invoice_item" do
      10.times do
        FactoryGirl.create(:invoice)
      end

      FactoryGirl.create(
        :invoice_item,
        id: 1,
        invoice: FactoryGirl.create(:invoice, id: 20)
      )

      get :show, params: { id: 1 }

      expect(response.status).to eq(200)
      expect(assigns(:invoice).id).to eq(20)
    end

    it "does not retrieve an invoice unrelated to that invoice_item" do
      3.times do |n|
        FactoryGirl.create(:invoice, id: "#{n+1}")
      end

      FactoryGirl.create(
        :invoice_item,
        id: 1,
        invoice: FactoryGirl.create(:invoice)
      )

      get :show, params: { id: 1 }

      expect(assigns(:invoice)).to_not be_within(1).of(2)
    end
  end
end
