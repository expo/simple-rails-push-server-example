class CreateTokens < ActiveRecord::Migration
  def change
    create_table :tokens do |t|
      t.text :value

      t.timestamps null: false
    end

    add_index :tokens, :value, unique: true
  end
end
