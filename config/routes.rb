require 'api_constraints'
Rails.application.routes.draw do


	devise_for :admins
	namespace :api, defaults: {format: 'json'} do
		scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
			match '/' => "shorts#create" , :via => ['post']
			match '/:slug' => "shorts#show" , :via => ['get']
		end

	end
	resources :shorts , :path => "/s" 
	resources :users , :path => "/a"
	root :to => "shorts#new" 
	match 's/:id/delete' => "shorts#delete" , :via => ['get','post','delete'] , :as => :delete
	
	match '/about' => "page#about", :via => ['get']
	match '/api' => "page#api", :via => ['get'] , :as => :api_doc
	match '/contact' => "page#contact" , :via => ['get']
	match '/report' => "page#report" , :via => ['get']
	match "/:id" => "shorts#redirect" , :via => ['get']


end
