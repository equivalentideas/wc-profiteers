namespace :opencorporates do
  desc "Get company data from opencorporates"
  task :get_company_data => :environment do
    require 'open-uri'

    oc_url_base = "http://api.opencorporates.com/v0.4.1/companies/au/"

    on_opencorporates = 0

    Contractor.where.not(acn: nil).each do |contractor|
      # if the company exists on opencorporates
      begin
        data = JSON.parse(open(oc_url_base + contractor.acn + '/data').read)["results"]["data"]
        # Has data
        if !data.empty?
          data.each do |datum|
            if datum["datum"]["data_type"] == "Website"
              contractor.update!(website: datum["datum"]["description"])
              puts "Updated #{contractor.name} website from opencorporates"
              on_opencorporates += 1
            end
          end
        else
          puts "#{contractor.name} is on OC but has no data items"
        end
      rescue OpenURI::HTTPError => e
        puts "#{e} for #{oc_url_base + contractor.acn + '/data'} #{contractor.name}"
      end
    end

    msg = "#{on_opencorporates} of #{Contractor.where.not(acn: nil).count} contractors with ACNs on OC."
    msg += " #{Contractor.where(acn: nil).count} had no ACN."
    puts msg
  end
end
