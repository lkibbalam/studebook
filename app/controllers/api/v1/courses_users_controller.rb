module Api
  module V1
    class CoursesUsersController < ApplicationController
      before_action :set_user, only: %i[padawan]

      def show
        respond_with(current_user.courses_users.as_json(except: %i[course_id student_id], include: { course:
                                                            { except: %i[author_id created_at updated_at team_id] } }))
        # TODO: update tests
      end

      def padawan
        respond_with(@user.courses_users.as_json(except: %i[course_id student_id], include: { course:
                                                  { except: %i[author_id created_at updated_at team_id] } }))
      end

      private

      def set_user
        @user = User.find(params[:id])
      end
    end
  end
end
