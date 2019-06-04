# frozen_string_literal: true

require 'rails_helper'

describe 'users_controller_spec' do
  let!(:admin) { create(:user, :admin) }
  let!(:teams) { create_list(:team, 2) }
  let!(:users) { create_list(:user, 9, team: teams.first) }

  describe 'GET #index' do
    context 'non authenticate request' do
      before { get "/api/v1/teams/#{teams.first.id}/users" }

      it_behaves_like 'non authenticate request'
    end

    context 'when authenticate' do
      before { get "/api/v1/teams/#{teams.first.id}/users", headers: authenticated_header(admin) }

      it_behaves_like 'authenticate request'
      it_behaves_like 'response body with 10 objects'
    end
  end

  describe 'GET #show' do
    context 'non authenticate request' do
      before { get "/api/v1/teams/#{teams.first.id}/users" }
      it_behaves_like 'non authenticate request'
    end

    context 'authenticate request' do
      before { get "/api/v1/users/#{users.first.id}", headers: authenticated_header(admin) }

      it_behaves_like 'authenticate request'

      %w[mentor_id team_id first_name last_name role phone github_url email].each do |attr|
        it "user object attributes contains #{attr}" do
          expect(response.body).to be_json_eql(users.first.send(attr.to_sym).to_json).at_path("data/attributes/#{attr.camelize(:lower)}")
        end
      end
    end
  end

  describe 'POST #create' do
    context 'non authenticate request' do
      let(:user_attributes) { attributes_for(:user) }
      before { post "/api/v1/teams/#{teams.first.id}/users", params: { user: user_attributes } }
      it_behaves_like 'non authenticate request'
    end

    context 'authenticate request' do
      let(:create_user) do
        post "/api/v1/teams/#{teams.first.id}/users", params: { user: user_attributes },
                                                      headers: authenticated_header(user)
      end
      context 'when admin creates user' do
        let(:user_attributes) { attributes_for(:user) }
        let!(:user) { create(:user, :admin) }
        it { expect { create_user }.to change(User, :count).by(1) }

        context 'when valid data' do
          before { create_user }

          it 'should have status 201 created' do
            expect(response).to have_http_status(:created)
          end

          %w[mentor_id team_id first_name last_name role phone github_url email].each do |attr|
            it "response should have user with #{attr}" do
              expect(response.body).to be_json_eql(User.find_by(email: user_attributes[:email])
                .send(attr.to_sym).to_json).at_path("data/attributes/#{attr.camelize(:lower)}")
            end
          end
        end

        context 'when invalid data' do
          let(:user_attributes) { attributes_for(:user, email: ' ', password: '') }
          let!(:user) { create(:user, :admin) }

          it { expect { create_user }.to_not change(User, :count) }

          it 'schould have status 422 unprocessable_entity' do
            create_user
            expect(response).to have_http_status(:unprocessable_entity)
            expect(JSON.parse(response.body)['message'])
              .to eq("Validation failed: Email empty, Password can't be blank")
          end
        end
      end
      context 'when student creates user' do
        let(:user_attributes) { attributes_for(:user) }
        let!(:user) { create(:user, :student) }

        it { expect { create_user }.to_not change(User, :count) }

        it 'schould have status 401 unauthorized' do
          create_user

          expect(response).to have_http_status(:unauthorized)
        end
      end
    end
  end

  describe 'PATCH #update' do
    context 'non authenticate request' do
      before do
        patch "/api/v1/users/#{users.first.id}",
              params: { user: { first_name: 'NewFirst', last_name: 'NewLast', phone: '0' } }
      end

      it_behaves_like 'non authenticate request'
    end

    context 'authenticate request' do
      before do
        patch "/api/v1/users/#{users.first.id}",
              params: { user: { first_name: 'NewFirst', last_name: 'NewLast',
                                phone: 0 } },
              headers: authenticated_header(users.first)
        users.first.reload
      end

      it { expect(users.first.first_name).to eql('NewFirst') }
      it { expect(users.first.last_name).to eql('NewLast') }
      it { expect(users.first.phone).to eql('0') }
    end
    context 'admin`s request' do
      before do
        patch "/api/v1/users/#{users.first.id}",
              params: { user: { first_name: 'NewFirst', last_name: 'NewLast',
                                phone: 0, email: 'NewEmail@mail.ru', role: :staff } },
              headers: authenticated_header(admin)
        users.first.reload
      end
      it { expect(users.first.email).to eql('NewEmail@mail.ru') }
      it { expect(users.first.role).to eql('staff') }
    end
  end

  describe 'DELETE #destroy' do
    context 'non authenticate request' do
      before { delete "/api/v1/users/#{users.first.id}" }
      it_behaves_like 'non authenticate request'
    end

    it {
      expect do
        delete "/api/v1/users/#{users.first.id}", headers: authenticated_header(admin)
      end.to change(User, :count).by(-1)
    }
  end
end
