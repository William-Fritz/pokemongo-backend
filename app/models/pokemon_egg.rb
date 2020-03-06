class PokemonEgg < ApplicationRecord
  belongs_to :player, optional: true
end
