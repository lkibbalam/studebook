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

Production environment

just need to add -f docker-compose.production.yml to each comand

example:

build images
1) docker-compose -f docker-compose.production.yml build

create db and make migrations and seeds
2)  docker-compose run app bundle exec rake db:create RAILS_ENV=production
    docker-compose run app bundle exec rake db:migrate RAILS_ENV=production
    docker-compose run app bundle exec rake db:seed RAILS_ENV=production

run app environmant on background
3)docker-compose -f docker-compose.production.yml up -d
  
.....
wellcome now you can call api

study.ruby.nixdev.co


Restore DB

1)copy db file to remote server
scp latest.dump dev@study.ruby.nixdev.co:~/var/www/studybook-api/latest.dump

2) restore db from app's folder on remote
cat latest.dump | docker exec -i $(docker-compose ps -q db) pg_restore --no-owner -U postgres -d studybook-api-production-db -1 --clean

