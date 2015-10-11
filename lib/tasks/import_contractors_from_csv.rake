namespace :import_from_csv do
  desc "Import contractors from CSV"
  task :contractors, [:csv_path] => :environment do |t, args|
    current_count = Contractor.count
    Contractor.import_contractors_from_csv(args.csv_path)
    puts "Created #{Contractor.count - current_count} new contractors"
  end
end
