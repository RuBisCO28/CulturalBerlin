class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|

      t.string :name, null: false
      t.date :date, null: false
      t.string :source, null: false
      t.string :url, null: false
    end
  end
end
