### shorty is simple url shortner 
Demo : http://calm-meadow-6186.herokuapp.com/

![alt shorty](https://mediacru.sh/download/8p5DPC3cJ712.png)


````bash
git clone git@github.com:alokyadav15/shorty.git shorty
cd shorty
bundle install
rake db:migrate 
rails server 

````

### config .
1. create admin using `rails c` (console ) 
2. enter recaptcha credentials in `config/initializers/recaptcha.rb`
3. start develpment server `rails s`   
then open your browser and point to `localhost:3000` 

### Troubleshooting 
Please Check these files and customize them accordingly 

app/controllers/users_controller.rb
app/views/users/show.html.erb
config/database.yml
config/environments/production.rb
config/initializers/devise.rb
config/secrets.yml


### to-do 
1. negative captcha 