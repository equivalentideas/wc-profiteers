namespace :morph do
  desc "Get contractors from morph.io api"
  task :get_contractors => :environment do
    current_count = Contractor.count
    Contractor.import_contractors_from_morph
    puts "Created #{Contractor.count - current_count} new contractors"
  end

  desc "Get the contracts for each contractor"
  task :get_contracts => :environment do
    Contract.import_contracts_from_morph
  end

  desc "Update contractors then contracts from morph.io"
  task :update_all => [:get_contractors, :get_contracts]
end
