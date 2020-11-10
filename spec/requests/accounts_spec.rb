require 'rails_helper'

RSpec.describe '/accounts', type: :request do
  let(:account_ownership) { create(:account_ownership) }
  let(:user) { account_ownership.user }
  let(:account) { account_ownership.account }

  before { sign_in user }

  describe 'GET /index' do
    it 'renders a successful response' do
      get accounts_url
      expect(response).to be_successful
      expect(response.body).to include(account.name)
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get account_url(account)
      expect(response).to be_successful
      expect(response.body).to include(account.name)
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_account_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'render a successful response' do
      get edit_account_url(account)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    let(:valid_attributes) do
      {
        name: Faker::Lorem.word,
        note: Faker::Lorem.sentence,
        balance: Faker::Number.number(digits: 4)
      }
    end
    let(:invalid_attributes) do
      {
        title: Faker::Lorem.word,
        user: user
      }
    end

    context 'with valid parameters' do
      it 'creates a new Account' do
        expect do
          post accounts_url, params: { account: valid_attributes }
        end.to change(Account, :count).by(1)
      end

      it 'redirects to the created account' do
        post accounts_url, params: { account: valid_attributes }
        expect(response).to redirect_to(account_url(Account.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Account' do
        expect do
          post accounts_url, params: { account: invalid_attributes }
        end.to change(Account, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post accounts_url, params: { account: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'PATCH /update' do
    let(:new_attributes) do
      {
        name: Faker::Lorem.word,
        note: Faker::Lorem.sentence,
        balance: Faker::Number.number(digits: 4)
      }
    end

    it 'updates the requested account' do
      patch account_url(account), params: { account: new_attributes }
      account.reload
      expect(account.name).to eq(new_attributes[:name])
    end

    it 'redirects to the account' do
      patch account_url(account), params: { account: new_attributes }
      account.reload
      expect(response).to redirect_to(account_url(account))
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested account' do
      expect { delete account_url(account) }.to change(Account, :count).by(-1)
    end

    it 'redirects to the accounts list' do
      delete account_url(account)
      expect(response).to redirect_to(accounts_url)
    end
  end
end
