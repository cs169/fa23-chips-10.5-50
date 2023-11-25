# frozen_string_literal: true

require 'rails_helper'

describe UserController do
  describe 'profile' do
    it 'sets @user to created user' do
      user = create(:user)
      session[:current_user_id] = user.id
      get :profile
      expect(assigns(:user)).to eq(user)
    end
  end
end
