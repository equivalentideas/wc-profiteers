class AddAllToContracts < ActiveRecord::Migration
  def change
    add_column :contracts, :date_scraped, :date
    add_column :contracts, :agency, :string
    add_column :contracts, :provisions_for_additional_services, :text
    add_column :contracts, :method_of_tendering, :string
    add_column :contracts, :provisions_for_changing_value, :text
    add_column :contracts, :provisions_for_renegotiation, :text
    add_column :contracts, :tender_evaluation_criteria, :text
    add_column :contracts, :piggyback_clause, :boolean
    add_column :contracts, :subcontractors, :text
  end
end
