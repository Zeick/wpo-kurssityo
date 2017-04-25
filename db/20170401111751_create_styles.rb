# Oh boy, jos tämä toimii olen positiivisesti yllättynyt...
class CreateStyles < ActiveRecord::Migration[5.0]
  def change
    create_table :styles do |t|
      t.string :name
      t.text :description
      t.timestamps null: false
    end
  end
end
