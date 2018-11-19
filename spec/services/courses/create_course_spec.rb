# frozen_string_literal: true

require 'rails_helper'

module Courses
  describe CreateCourse do
    let(:create_course) do
      described_class.call(params: params)
    end

    context 'create course with pavild data' do
      let(:params) do
        {
          title: Faker::Lorem.sentence,
          description: Faker::Lorem.paragraph,
          team_id: create(:team).id,
          author_id: create(:author).id
        }
      end

      it 'expect to change course count in db' do
        expect { create_course }.to change(Course, :count).by(1)
      end
    end

    context 'create course with invalid data' do
      let(:params) do
        {
          title: '',
          description: '',
          team_id: nil,
          author_id: nil
        }
      end

      it 'expect to not hange course count in db' do
        expect { create_course }.to change(Course, :count).by(0)
      end
    end
  end
end
