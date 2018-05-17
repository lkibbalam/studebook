require 'rails_helper'

describe 'users_controller_spec' do
  let!(:teams) { create_list(:team, 2) }
  let!(:users) { create_list(:user, 10, team: teams.first) }

  describe 'GET #index' do
    context 'non authenticate request' do
      before { get "/api/v1/teams/#{teams.first.id}/users" }

      it_behaves_like 'non authenticate request'
    end

    context 'when authenticate' do
      context 'when requests' do
        before { get "/api/v1/teams/#{teams.first.id}/users", headers: authenticated_header(users.first) }

        it_behaves_like 'authenticate request'
        it_behaves_like 'resource contain'
      end

      context 'when resource don`t have a users' do
        before { get "/api/v1/teams/#{teams.second.id}/users", headers: authenticated_header(users.first) }

        it_behaves_like 'authenticate request'

        it 'when get resource nested users' do
          expect(JSON.parse(response.body).size).to eq 0
        end
      end
    end
  end

  describe 'GET #show' do
    context 'non authenticate request' do
      before { get "/api/v1/teams/#{teams.first.id}/users" }
      it_behaves_like 'non authenticate request'
    end

    context 'authenticate request' do
      before { get "/api/v1/users/#{users.first.id}", headers: authenticated_header(users.first) }

      it_behaves_like 'authenticate request'

      %w[id role first_name last_name phone].each do |attr|
        it "user object contains #{attr}" do
          expect(response.body).to be_json_eql(users.first.send(attr.to_sym).to_json).at_path(attr)
        end
      end
    end
  end

  describe 'POST #create' do
    context 'non authenticate request' do
      before { post "/api/v1/teams/#{teams.first.id}/users", params: { user: attributes_for(:user) } }
      it_behaves_like 'non authenticate request'
    end

    let(:create_user) do
      post "/api/v1/teams/#{teams.first.id}/users", params: { user: attributes_for(:user) },
                                                    headers: authenticated_header(users.first)
    end

    it { expect { create_user }.to change(User, :count).by(1) }
  end

  describe 'PATCH #update' do
    context 'non authenticate request' do
      before do
        patch "/api/v1/users/#{users.first.id}",
              params: { user: { first_name: 'NewFirst', last_name: 'NewLast', phone: 0 } }
      end

      it_behaves_like 'non authenticate request'
    end

    context 'authenticate' do
      before do
        patch "/api/v1/users/#{users.first.id}",
              params: { user: { first_name: 'NewFirst', last_name: 'NewLast',
                                phone: 0, email: 'NewEmail@mail.ru' } },
              headers: authenticated_header(users.first)
        users.first.reload
      end

      it { expect(users.first.first_name).to eql('NewFirst') }
      it { expect(users.first.last_name).to eql('NewLast') }
      it { expect(users.first.phone).to eql(0) }
      it { expect(users.first.email).to eql('NewEmail@mail.ru') }
    end
  end

  describe 'DELETE #destroy' do
    context 'non authenticate request' do
      before { delete "/api/v1/users/#{users.first.id}" }
      it_behaves_like 'non authenticate request'
    end

    it {
      expect do
        delete "/api/v1/users/#{users.first.id}", headers: authenticated_header(users.first)
      end.to change(User, :count).by(-1)
    }
  end
end
