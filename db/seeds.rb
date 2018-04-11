Team.create(
  [
    {
      title: 'Ruby',
      description: 'some funny mans and one girl'
    },
    {
      title: 'C+',
      description: 'very smart mans'
    },
    {
      title: 'C#',
      description: 'very strange mans'
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
      mentor_id: 2
    },
    {
      first_name: 'Rubyfirst',
      last_name: 'Rubyfirst',
      team_id: 1,
      phone: 9999,
      mentor_id: 2
    },
    {
      first_name: 'second',
      last_name: 'third',
      team_id: 2,
      phone: 2222,
      mentor_id: 1
    },
    {
      first_name: 'second',
      last_name: 'third',
      team_id: 3,
      phone: 2222,
      mentor_id: 2
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
      title: 'HeadForth',
      author_id: 3
    }
  ]
)

CoursesUser.create(
  [
    {
      student_id: 1,
      course_id: 1,
      opinion: 'lalalend',
      chat: 'some chat link'
    },
    {
      student_id: 2,
      course_id: 1,
      opinion: 'lalalend',
      chat: 'some chat link'
    },
    {
      student_id: 1,
      course_id: 2,
      opinion: 'lalalend',
      chat: 'some chat link'
    },
    {
      student_id: 1,
      course_id: 3,
      opinion: 'lalalend',
      chat: 'some chat link'
    }
  ]
)

Lesson.create(
  [
    {
      course_id: 1,
      description: 'MyDescr',
      task: 'MyTask',
      video: 'MyVideo',
      material: 'MyMaterial'
    },
    {
      course_id: 1,
      description: 'MyDescr',
      task: 'MyTask',
      video: 'MyVideo',
      material: 'MyMaterial'
    },
    {
      course_id: 2,
      description: 'MyDescr',
      task: 'MyTask',
      video: 'MyVideo',
      material: 'MyMaterial'
    },
    {
      course_id: 3,
      description: 'MyDescr',
      task: 'MyTask',
      video: 'MyVideo',
      material: 'MyMaterial'
    }
  ]
)

LessonsUser.create(
  [
    {
      lesson_id: 1,
      student_id: 1,
      status: 0,
      mark: 10
    },
    {
      lesson_id: 1,
      student_id: 1,
      status: 0,
      mark: 10
    },
    {
      lesson_id: 1,
      student_id: 2,
      status: 0,
      mark: 99
    },
    {
      lesson_id: 1,
      student_id: 3,
      status: 0,
      mark: 100
    }
  ]
)
