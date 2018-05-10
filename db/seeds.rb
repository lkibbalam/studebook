Team.create(
  [
    {
      title: 'Ruby',
      description: 'some funny men and one girl'
    },
    {
      title: 'C+',
      description: 'very smart men'
    },
    {
      title: 'C#',
      description: 'very strange men'
    }
  ]
)

User.create(
  [
    {
      first_name: 'first',
      last_name: 'first',
      team_id: 1,
      phone: 1111,
      mentor_id: nil,
      email: 'seed1@mail.com',
      password: '12345678',
      role: 5
    },
    {
      first_name: 'second',
      last_name: 'second',
      team_id: 1,
      phone: 9999,
      mentor_id: 1,
      email: 'seed2@mail.com',
      password: '12345678',
      role: 1
    },
    {
      first_name: 'third',
      last_name: 'third',
      team_id: 2,
      phone: 2222,
      mentor_id: 1,
      email: 'seed3@mail.com',
      password: '12_345_678',
      role: 1
    },
    {
      first_name: 'forth',
      last_name: 'forth',
      team_id: 3,
      phone: 2222,
      mentor_id: 1,
      email: 'seed4@mail.com',
      password: '12345678',
      role: 1
    }
  ]
)

Course.create(
  [
    {
      team_id: 1,
      description: 'first at all',
      title: 'HeadFirst',
      author_id: 1
    },
    {
      team_id: 1,
      description: 'second at all',
      title: 'HeadSecond',
      author_id: 1
    },
    {
      team_id: 2,
      description: 'third at all',
      title: 'HeadThird',
      author_id: 2
    },
    {
      team_id: 3,
      description: 'forth at all',
      title: 'HeadFourth',
      author_id: 3
    }
  ]
)

Lesson.create(
  [
    {
      course_id: 1,
      description: 'MyDescr1',
      task: 'MyTask1',
      material: 'MyMaterial1'
    },
    {
      course_id: 1,
      description: 'MyDescr2',
      task: 'MyTask2',
      material: 'MyMaterial2'
    },
    {
      course_id: 1,
      description: 'MyDescr3',
      task: 'MyTask3',
      material: 'MyMaterial3'
    },
    {
      course_id: 2,
      description: 'MyDescr1',
      task: 'MyTask1',
      material: 'MyMaterial1'
    },
    {
      course_id: 2,
      description: 'MyDescr2',
      task: 'MyTask2',
      material: 'MyMaterial2'
    },
    {
      course_id: 3,
      description: 'MyDescr1',
      task: 'MyTask1',
      material: 'MyMaterial1'
    },
    {
      course_id: 3,
      description: 'MyDescr2',
      task: 'MyTask2',
      material: 'MyMaterial2'
    }
  ]
)

Video.create(
  [
    {
      lesson_id: 1,
      title: 'Video1',
      src: 'https://www.youtube.com/embed/t5KR9oAmq6A?start=33'
    },
    {
      lesson_id: 1,
      title: 'Video2',
      src: 'https://www.youtube.com/embed/UGoCSMr0k6U'
    },
    {
      lesson_id: 1,
      title: 'Video2',
      src: 'https://www.youtube.com/embed/Qs8c6FCwkbk'
    },
    {
      lesson_id: 2,
      title: 'Video1',
      src: 'https://www.youtube.com/embed/t5KR9oAmq6A?start=33'
    },
    {
      lesson_id: 2,
      title: 'Video2',
      src: 'https://www.youtube.com/embed/UGoCSMr0k6U'
    },
    {
      lesson_id: 3,
      title: 'Video1',
      src: 'https://www.youtube.com/embed/Qs8c6FCwkbk'
    },
    {
      lesson_id: 3,
      title: 'Video2',
      src: 'https://www.youtube.com/embed/Qs8c6FCwkbk'
    }
  ]
)

#
# LessonsUser.create(
#   [
#     {
#       lesson_id: 1,
#       student_id: 1,
#       status: 0,
#       mark: 10
#     },
#     {
#       lesson_id: 1,
#       student_id: 1,
#       status: 0,
#       mark: 10
#     },
#     {
#       lesson_id: 1,
#       student_id: 2,
#       status: 0,
#       mark: 99
#     },
#     {
#       lesson_id: 1,
#       student_id: 3,
#       status: 0,
#       mark: 100
#     }
#   ]
# )

# CoursesUser.create(
#   [
#     {
#       student_id: 1,
#       course_id: 1,
#       opinion: 'lalaland',
#       chat: 'some chat link'
#     },
#     {
#       student_id: 2,
#       course_id: 1,
#       opinion: 'lalaland',
#       chat: 'some chat link'
#     },
#     {
#       student_id: 1,
#       course_id: 2,
#       opinion: 'lalaland',
#       chat: 'some chat link'
#     },
#     {
#       student_id: 1,
#       course_id: 3,
#       opinion: 'lalaland',
#       chat: 'some chat link'
#     }
#   ]
# )
