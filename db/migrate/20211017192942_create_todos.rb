class CreateTodos < ActiveRecord::Migration[6.1]
  def change
    create_table :todos do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
