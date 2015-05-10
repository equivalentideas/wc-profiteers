class CreateContracts < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.text :description
      t.string :url
      t.float :value
      t.date :start_date
      t.date :end_date
      t.string :can_id

      t.timestamps
    end
  end
end
