require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "#index" do
    context "as a logged-in admin" do
      before do
        @admin_user = FactoryBot.create(:user)
      end

      it "returns success" do
        session[:user_id] = @admin_user.id
        get :index
        expect(response).to be_success
      end
    end

    context "as a guest" do
      before do
        session[:user_id] = nil
      end

      it "returns success" do
        get :index
        expect(response).to be_success
      end
    end
  end

  describe "#show" do
    before do
      @admin_user = FactoryBot.create(:user)
    end
    context "as a logged-in admin" do
      it "returns success" do
        session[:user_id] = @admin_user.id
        get :show, params: { id: @admin_user.id}
        expect(response).to be_success
      end
    end

    context "as a guest" do
      before do
        session[:user_id] = nil
      end

      it "returns 200" do
        get :show,params: { id: @admin_user.id }
        expect(response).to have_http_status(200)
      end
    end
  end
end
