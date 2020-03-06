Rails.application.routes.draw do
  resources :players, :pokemons, :pokemon_eggs, :shops, :inventories
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
