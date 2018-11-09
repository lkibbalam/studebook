# frozen_string_literal: true

require 'rails_helper'

describe StudybookApiSchema do
  let(:context) { {} }
  let(:variables) { {} }
  let(:result) do
    StudybookApiSchema.execute(
      query_string,
      context: context,
      variables: variables
    )
  end

  describe 'a specific query' do
    let(:query_string) { %({ me { email } }) }

    context "when there's no current user" do
      it 'is nil' do
        expect(result['data']['me']).to eq(nil)
      end
    end

    context "when there's a current user" do
      let(:user) { create(:user) }
      let(:context) { { me: user } }

      it "shows the user's email" do
        email = result['data']['me']['email']
        expect(email).to eq(user.email)
      end
    end
  end
end
