class CreatePokemonEggs < ActiveRecord::Migration[6.0]
  def change
    create_table :pokemon_eggs do |t|
      t.string :type
      t.int :distance_traveled
      t.int :distance_needed

      t.timestamps
    end
  end
end
