Run the project localy
1) docker-compose build

2)  docker-compose run bundle exec rake db:create
    docker-compose run bundle exec rake db:migrate
    docker-compose run bundle exec rake db:seed

3) if you need debugger, pry .etc
    docker-compose up -d && docker attach $(docker-compose ps -q app) or
    docker-compose run --service-ports app or 
    docker-compose up and docker attach $(docker-compose ps -q app) in another tab

  if you dont need any debuggers just
    docker-compose up

open localhost:3001 in browser
open localhost:3001/graphiql (GrapqhQL shema docs and you can test sime requests here)
graphql query example

query {
  courses {
    edges {
      node {
        id
        title
      }
    }
  }
}