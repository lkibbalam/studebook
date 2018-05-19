class CoursesUser < ApplicationRecord
  belongs_to :course
  belongs_to :student, class_name: 'User', foreign_key: :student_id
  has_many :comments, as: :commentable, dependent: :destroy

  validates :student, uniqueness: { scope: :course }

  enum status: { current: 0, archived: 1 }

  after_create :create_course_lessons

  def create_course_lessons
    course.lessons.each { |lesson| LessonsUser.create(lesson_id: lesson.id, student_id: student.id) }
    LessonsUser.find_by(student_id: student.id).update(status: 2)
    # TODO: wright test
  end
end
