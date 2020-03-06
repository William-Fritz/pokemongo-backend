class CreatePokemonEggs < ActiveRecord::Migration[6.0]
  def change
    create_table :pokemon_eggs do |t|
      t.string :type
      t.integer :distance_traveled
      t.integer :distance_needed

      t.timestamps
    end
  end
end
