# frozen_string_literal: true

require 'rails_helper'

describe 'courses_controller_spec' do
  let!(:user) { create(:user) }
  let!(:team) { create(:team) }
  let!(:courses) { create_list(:course, 10, author: user, team: team) }

  describe 'GET #index' do
    context 'when non authenticate' do
      before { get "/api/v1/teams/#{courses.first.team_id}/courses" }

      it_behaves_like 'non authenticate request'
    end

    context 'when authenticate' do
      before do
        get "/api/v1/teams/#{courses.first.team_id}/courses", headers: authenticated_header(user)
      end

      it_behaves_like 'authenticate request'
      it_behaves_like 'resource contain'
    end
  end

  describe 'GET #show' do
    context 'when non authenticate' do
      before { get "/api/v1/courses/#{courses.first.id}" }

      it_behaves_like 'non authenticate request'
    end

    context 'when authenticate' do
      before { get "/api/v1/courses/#{courses.first.id}", headers: authenticated_header(user) }

      it_behaves_like 'authenticate request'

      %w[id team_id author_id description title created_at updated_at].each do |attr|
        it "course object contains #{attr}" do
          expect(response.body).to be_json_eql(courses.first.send(attr.to_sym).to_json).at_path(attr)
        end
      end
    end
  end

  describe 'POST #create' do
    let!(:team) { create(:team) }

    context 'when non authenticate' do
      before { post "/api/v1/teams/#{team.id}/courses", params: { course: attributes_for(:course) } }
      it_behaves_like 'non authenticate request'
    end

    context 'when authenticate' do
      let(:create_course) do
        post "/api/v1/teams/#{team.id}/courses", params: { course: attributes_for(:course) },
                                                 headers: authenticated_header(user)
      end

      it 'when attributes is valid' do
        expect { create_course }.to change(Course, :count).by(1)
      end
    end
  end

  describe 'PATCH #update' do
    context 'when non authenticate' do
      before do
        patch "/api/v1/courses/#{courses.first.id}", params: { course: { title: 'NewTitle', description: 'NewDes' } }
      end

      it_behaves_like 'non authenticate request'
    end

    context 'when authenticate' do
      before do
        patch "/api/v1/courses/#{courses.first.id}", params: { course: { title: 'NewTitle', description: 'NewDes' } },
                                                     headers: authenticated_header(user)
        courses.first.reload
      end

      it { expect(courses.first.title).to eql('NewTitle') }
      it { expect(courses.first.description).to eql('NewDes') }
    end
  end

  describe 'DELETE #destory' do
    context 'when non authenticate' do
      before { delete "/api/v1/courses/#{courses.first.id}" }

      it_behaves_like 'non authenticate request'
    end

    context 'when authenticate' do
      let(:delete_course) { delete "/api/v1/courses/#{courses.first.id}", headers: authenticated_header(user) }

      it { expect { delete_course }.to change(Course, :count).by(-1) }
    end
  end

  describe 'Nested comments' do
    let!(:subject) { create(:course) }

    describe 'GET #comments' do
      it_behaves_like 'Commentable_comment'
    end

    describe 'POST #create_comment' do
      it_behaves_like 'Commentable_create'
    end

    describe 'PATCH #update_comment' do
      it_behaves_like 'Commentable_update'
    end

    describe 'DELETE #destroy_comment' do
      it_behaves_like 'Commentable_destroy'
    end
  end
end
