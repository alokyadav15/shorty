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

### to-do 
1. negative captcha 