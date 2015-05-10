class CreateContractors < ActiveRecord::Migration
  def change
    create_table :contractors do |t|
      t.string :name
      t.integer :acn
      t.string :street_adress
      t.string :string
      t.string :city
      t.string :state
      t.integer :postcode
      t.string :country

      t.timestamps
    end
  end
end
