module Api
  module V1
    class LessonsUsersController < ApplicationController
      def mark; end

      def done
        @lesson_user = LessonsUser.find_by(student_id: current_user.id, lesson_id: @lesson.id)
      end
    end
  end
end
