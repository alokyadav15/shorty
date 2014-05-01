### shorty is simple url shortner 

````bash
git clone git@github.com:alokyadav15/shorty.git shorty
cd shorty
bundle install
rake db:migrate 
rails server 

````

### config .
1 . open admins model and uncomment registrable 
2 . enter recaptcha credentials in `config/initializers/recaptcha.rb`

then open your browser and point to `localhost:3000` 

### to-do 
1. negative captcha 