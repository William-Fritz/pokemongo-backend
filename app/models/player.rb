class Player < ApplicationRecord
  has_many :pokemons
  has_many :inventories
  has_many :pokemon_eggs
end
