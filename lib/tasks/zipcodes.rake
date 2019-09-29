require "csv"

namespace :db do
  desc "Imports zipcodes from the CSV file"
  task zipcodes: :environment do
    Zipcode.destroy_all

    CSV.foreach("db/zipcodes.csv", col_sep: ";", headers: true) do |line|
      code = line.to_hash["pc6"]
      Zipcode.create!(code: code.upcase) if code.present?
    end
  end
end
