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

Task.create(
  [
    { lesson_id: 1,
      title: 'Задача 1-1',
      description: 'Вы можете проверять работу своих программ руками. Но раз вы уже умеете программировать,
                       почему бы не написать отдельную программу, которая бы проверяла вашу программу. Логично?
                        Эта гениальная идея давно пришла в голову программистам и хороший программист всегда пишет еще и
                         тесты. Это убивает сразу кучу зайцев.' },
    { lesson_id: 1,
      title: 'Задача 1-2',
      description: 'An Idea board frontend app built using Create React App, based on the Rails 5 API and React.js
                       tutorial - How to make an Idea board app.
                      The app talks to an API which has endpoints for adding, editing and deleting ideas.
                        See this Rails 5.1 API app code for the backend API.' },
    { lesson_id: 1,
      title: 'Задача 1-3',
      description: 'We’re going to build an idea board as a single page app (SPA), which displays ideas in the form of
                       square tiles.' },
    { lesson_id: 1,
      title: 'Задача 1-4',
      description: 'You can add new ideas, edit them and delete them. Ideas get auto-saved when the user focuses out of
                       the editing form.' },
    { lesson_id: 1,
      title: 'Задача 1-5',
      description: 'At the end of this tutorial, we’ll have a functional CRUD app, to which we can add some enhancements,
                     such as animations, sorting and search in a future tutorial.' }
  ]
)
