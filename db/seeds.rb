Team.create(
  [
    {
      title: 'Ruby',
      description: 'some funny men and one girl',
      img: 'https://t00.deviantart.net/l4YO2b97n-a86-ZYM9QfIvaZ6EM=/300x200/filters:fixed_height(100,100):origin()
              /pre00/af07/th/pre/f/2016/192/c/3/rubyrubyruby2_by_likeabaka-da9mdzr.png'
    },
    {
      title: 'C++',
      description: 'very smart men',
      img: 'https://t00.deviantart.net/l4YO2b97n-a86-ZYM9QfIvaZ6EM=/300x200/filters:fixed_height(100,100):origin()
              /pre00/af07/th/pre/f/2016/192/c/3/rubyrubyruby2_by_likeabaka-da9mdzr.png'
    },
    {
      title: 'C#',
      description: 'very strange men',
      img: 'https://t00.deviantart.net/l4YO2b97n-a86-ZYM9QfIvaZ6EM=/300x200/filters:fixed_height(100,100):origin()
              /pre00/af07/th/pre/f/2016/192/c/3/rubyrubyruby2_by_likeabaka-da9mdzr.png'
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
      material: 'MyMaterial1',
      title: 'Lesson 1'
    },
    {
      course_id: 1,
      description: 'MyDescr2',
      task: 'MyTask2',
      material: 'MyMaterial2',
      title: 'Lesson 3'
    },
    {
      course_id: 1,
      description: 'MyDescr3',
      task: 'MyTask3',
      material: 'MyMaterial3',
      title: 'Lesson 3'
    },
    {
      course_id: 2,
      description: 'MyDescr1',
      task: 'MyTask1',
      material: 'MyMaterial1',
      title: 'Lesson 1'
    },
    {
      course_id: 2,
      description: 'MyDescr2',
      task: 'MyTask2',
      material: 'MyMaterial2',
      title: 'Lesson 2'
    },
    {
      course_id: 3,
      description: 'MyDescr1',
      task: 'MyTask1',
      material: 'MyMaterial1',
      title: 'Lesson 1'
    },
    {
      course_id: 3,
      description: 'MyDescr2',
      task: 'MyTask2',
      material: 'MyMaterial2',
      title: 'Lesson 2'
    }
  ]
)

Video.create(
  [
    { course_id: 1,
      lesson_id: 1,
      title: 'Video1',
      src: 'https://www.youtube.com/embed/t5KR9oAmq6A?start=33' },
    { course_id: 1,
      lesson_id: 1,
      title: 'Video2',
      src: 'https://www.youtube.com/embed/UGoCSMr0k6U' },
    { course_id: 1,
      lesson_id: 1,
      title: 'Video3',
      src: 'https://www.youtube.com/embed/Qs8c6FCwkbk' },
    { course_id: 1,
      lesson_id: 2,
      title: 'Video1',
      src: 'https://www.youtube.com/embed/UGoCSMr0k6U' },
    { course_id: 1,
      lesson_id: 2,
      title: 'Video2',
      src: 'https://www.youtube.com/embed/t5KR9oAmq6A?start=33' },
    { course_id: 1,
      lesson_id: 3,
      title: 'Video1',
      src: 'https://www.youtube.com/embed/Qs8c6FCwkbk' },
    { course_id: 1,
      lesson_id: 3,
      title: 'Video2',
      src: 'https://www.youtube.com/embed/UGoCSMr0k6U' }
  ]
)
