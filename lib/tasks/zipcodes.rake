require "csv"

namespace :db do
  desc "Imports zipcodes from the CSV file"
  task zipcodes: :environment do
    sourcefile = "config/locales/custom/nl/zipcodes.csv"
    if (File.exists?(sourcefile))
      Zipcode.destroy_all
      # Check if file exists
      CSV.foreach(sourcefile, col_sep: ";", headers: true) do |line|
        code = line.to_hash["pc6"]
        Zipcode.create!(code: code.upcase) if code.present?
      end
    else
      puts 'Zipcode file not found. Skipping'
    end
  end
end
