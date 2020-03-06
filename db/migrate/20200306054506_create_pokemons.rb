class CreatePokemons < ActiveRecord::Migration[6.0]
  def change
    create_table :pokemons do |t|
      t.string :name
      t.integer :lvl
      t.integer :exp
      t.string :status
      t.string :type1
      t.string :type2
      t.string :move1
      t.string :move2
      t.boolean :item

      t.timestamps
    end
  end
end
