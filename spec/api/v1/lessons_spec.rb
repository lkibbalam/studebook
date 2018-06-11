# frozen_string_literal: true

require 'rails_helper'

describe 'lessons_controller_spec' do
  let!(:user) { create(:user) }
  let!(:admin) { create(:user, :admin) }
  let!(:course) { create(:course) }
  let!(:lessons) { create_list(:lesson, 10, tasks: create_list(:task, 3)) }
  let!(:lessons_user) { create(:lessons_user, student: user, lesson: lessons.first) }

  describe 'GET #index' do
    let(:lessons) { create_list(:lesson, 10, course: course) }
    context 'when non-authenticate' do
      before { get "/api/v1/courses/#{course.id}/lessons" }

      it_behaves_like 'non authenticate request'
    end

    context 'when authenticate' do
      before { get "/api/v1/courses/#{course.id}/lessons", headers: authenticated_header(user) }

      it_behaves_like 'authenticate request'

      it 'return 10 of resource objects' do
        expect(JSON.parse(response.body)['lessons'].size).to eq 10
      end
    end
  end

  #   describe 'GET #show' do
  #     context 'when non-authenticate' do
  #       before { get "/api/v1/lessons/#{lessons.first.id}" }
  #
  #       it_behaves_like 'non authenticate request'
  #     end
  #
  #     context 'when authenticate' do
  #       before { get "/api/v1/lessons/#{lessons.first.id}", headers: authenticated_header(user) }
  #
  #       it_behaves_like 'authenticate request'
  #
  #       %w[id course_id description material task].each do |attr|
  #         it "user object contains #{attr}" do
  #           expect(response.body).to be_json_eql(lessons.first.send(attr.to_sym).to_json).at_path(attr)
  #         end
  #       end
  #     end
  #   end

  describe 'POST #create' do
    context 'when non-authenticate' do
      before { post "/api/v1/courses/#{course.id}/lessons", params: { lesson: attributes_for(:lesson) } }

      it_behaves_like 'non authenticate request'
    end
    context 'when authenticate' do
      let(:create_lesson) do
        post "/api/v1/courses/#{course.id}/lessons", params: { lesson: attributes_for(:lesson) },
                                                     headers: authenticated_header(admin)
      end

      it 'when lesson with valid params' do
        expect { create_lesson }.to change(Lesson, :count).by(1)
      end
    end
  end

  describe 'PATCH #update' do
    context 'when non-authenticate' do
      before do
        patch "/api/v1/lessons/#{lessons.first.id}", params: { lesson: { task: 'NewTask', material: 'NewMaterial',
                                                                         description: 'NewDesc' } }
      end

      it_behaves_like 'non authenticate request'
    end

    context 'when authenticate' do
      before do
        patch "/api/v1/lessons/#{lessons.first.id}", params: { lesson: { task: 'NewTask', material: 'NewMaterial',
                                                                         description: 'NewDesc' } },
                                                     headers: authenticated_header(admin)
        lessons.first.reload
      end

      it { expect(lessons.first.description).to eql('NewDesc') }
      it { expect(lessons.first.material).to eql('NewMaterial') }
    end
  end

  describe 'DELETE #delete' do
    context 'when non-authenticate' do
      before { delete "/api/v1/lessons/#{lessons.first.id}" }

      it_behaves_like 'non authenticate request'
    end

    context 'when authenticate' do
      let(:delete_lesson) { delete "/api/v1/lessons/#{lessons.first.id}", headers: authenticated_header(admin) }
      it { expect { delete_lesson }.to change(Lesson, :count).by(-1) }
    end
  end

  describe 'PATCH #done' do
    context 'when non authenticate' do
      before { patch "/api/v1/lessons/#{lessons.first.id}/done", params: { id: lessons.first.id } }

      it_behaves_like 'non authenticate request'
    end

    context 'when authenticate request' do
      before do
        patch "/api/v1/lessons/#{lessons.first.id}/done",
              params: { id: lessons.first.id }, headers: authenticated_header(user)
      end
      it { expect(lessons_user.status).to eql('done') }
    end
  end

  describe 'Nested comments' do
    let!(:subject) { create(:lesson) }

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
