# frozen_string_literal: true

require 'rails_helper'

describe 'courses_controller_spec' do
  let!(:user) { create(:user) }
  let!(:admin) { create(:user, :admin) }
  let!(:team) { create(:team) }
  let(:course) { create(:course, author: user, team: team) }
  let!(:lessons) { create_list(:lesson, 3, tasks: create_list(:task, 3), course: course) }

  describe 'GET #index' do
    let!(:courses) { create_list(:course, 10, team: create(:team)) }

    context 'when non authenticate' do
      before { get "/api/v1/teams/#{courses.first.team_id}/courses" }

      it_behaves_like 'non authenticate request'
    end

    context 'when authenticate' do
      before do
        get "/api/v1/teams/#{courses.first.team_id}/courses", headers: authenticated_header(user)
      end

      it_behaves_like 'authenticate request'
      it_behaves_like 'response body with 10 objects'
    end
  end

  describe 'GET #show' do
    context 'when non authenticate' do
      before { get "/api/v1/courses/#{course.id}" }

      it_behaves_like 'non authenticate request'
    end

    context 'when authenticate' do
      before { get "/api/v1/courses/#{course.id}", headers: authenticated_header(user) }

      it_behaves_like 'authenticate request'

      %w[team_id author_id description title created_at updated_at].each do |attr|
        it "course object attributes contains #{attr}" do
          expect(response.body).to be_json_eql(course.send(attr.to_sym).to_json).at_path("data/attributes/#{attr}")
        end
      end

      it 'response body data contains type' do
        expect(response.body).to be_json_eql('courses'.to_json).at_path('data/type')
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
                                                 headers: authenticated_header(admin)
      end

      it 'when attributes is valid' do
        expect { create_course }.to change(Course, :count).by(1)
      end
    end
  end

  describe 'PATCH #update' do
    context 'when non authenticate' do
      before do
        patch "/api/v1/courses/#{course.id}", params: { course: { title: 'NewTitle', description: 'NewDes' } }
      end

      it_behaves_like 'non authenticate request'
    end

    context 'when authenticate' do
      before do
        patch "/api/v1/courses/#{course.id}", params: { course: { title: 'NewTitle', description: 'NewDes' } },
                                              headers: authenticated_header(admin)
        course.reload
      end

      it { expect(course.title).to eql('NewTitle') }
      it { expect(course.description).to eql('NewDes') }
    end
  end

  describe 'DELETE #destory' do
    context 'when non authenticate' do
      before { delete "/api/v1/courses/#{course.id}" }

      it_behaves_like 'non authenticate request'
    end

    context 'when authenticate' do
      let(:delete_course) { delete "/api/v1/courses/#{course.id}", headers: authenticated_header(admin) }

      it { expect { delete_course }.to change(Course, :count).by(-1) }
    end
  end

  describe 'POST #start_course' do
    context 'when non authenticate request' do
      before { post "/api/v1/courses/#{course.id}/start_course" }

      it_behaves_like 'non authenticate request'
    end

    context 'when authenticate request' do
      let(:start_course) do
        post "/api/v1/courses/#{course.id}/start_course", headers: authenticated_header(user)
      end

      it { expect { start_course }.to change(CoursesUser, :count).by(1) }
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
