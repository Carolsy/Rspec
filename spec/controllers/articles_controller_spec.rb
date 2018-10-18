require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do

  describe "#new" do
    context 'as a guest' do
      it 'redirects to login path' do
        get :new
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "#create" do
    context 'as a logged-in user' do
      before do
        @user = FactoryBot.build(:user)
      end
      it 'adds an article' do
        sign_in @user
        article_params = FactoryBot.attributes_for(:article).merge(user_id: @user.id)
        #params = { article: article_params }
        expect { post :create, params: { article: article_params } }.to change(@user.articles, :count).by(1)
      end

    end

    context 'as a guest' do
      before do
        @user = FactoryBot.build(:user)
      end
      it 'redirects to login path' do
        article_params = FactoryBot.attributes_for(:article).merge(user_id: @user.id)
        params = { article: article_params }
        post :create, params: { article: article_params }
        expect(response).to redirect_to new_user_session_path

      end
    end
  end

  describe '#edit' do
    context 'as a guest' do
      before do
        @user = FactoryBot.build(:user)
        @article = FactoryBot.build(:article)
      end

      it 'redirect to root_path' do
        sign_in @user
        article_params = FactoryBot.attributes_for(:article).merge(user_id: @user.id)
        get :edit, params: { id: @article.id, user_id: article_params[:user_id] }
        expect(response).to redirect_to new_user_session_path

      end
    end
  end

  describe '#destroy' do
    context 'as a guest' do
      before do
        @user = FactoryBot.build(:user)
        @article = FactoryBot.build(:article)
      end

      it 'redirect to articles_path' do
        article_params = FactoryBot.attributes_for(:article).merge(user_id: @user.id)
        #article_params = {:id => 1, :title => 'test', description => 'for test', :user_id => 1}
        delete :destroy, params: { id: @article.id, user_id: article_params[:user_id] }
      end
    end
  end


end
