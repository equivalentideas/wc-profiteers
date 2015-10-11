namespace :import_from_csv do
  desc "Import contractors from CSV"
  task :contractors, [:csv_path] => :environment do |t, args|
    current_count = Contractor.count
    Contractor.import_contractors_from_csv(args.csv_path)
    puts "Created #{Contractor.count - current_count} new contractors"
  end

  desc "Import contracts from CSV"
  task :contracts, [:csv_path] => :environment do |t, args|
    current_count = Contract.count
    Contract.import_contracts_from_csv(args.csv_path)
    puts "Created #{Contract.count - current_count} new contracts"
  end
end
