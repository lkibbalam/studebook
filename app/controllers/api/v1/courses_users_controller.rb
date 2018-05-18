module Api
  module V1
    class CoursesUsersController < ApplicationController
      def show
        respond_with(current_user.courses_users.as_json(except: %i[course_id student_id], include: { course:
                                                            { except: %i[author_id created_at updated_at team_id] } }))
        # TODO: update tests
      end
    end
  end
end
