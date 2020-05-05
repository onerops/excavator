# README


* docker-compose up

* Edit `.env` with next configuration 
```yaml
GMAP_KEY=api_key
DATABASE_URL=postgres://postgres:pgpassword@localhost:8001/app_development
``` 
* rake db:create && rake db:migrate

* yarn install

* rails s
