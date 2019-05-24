class ApplicationMailer < ActionMailer::Base
  helper :settings
  helper :application
  if !ActiveRecord::Base.connection.table_exists?("settings")
    default from: ENV["SMTP_FROM"] || "noreply@consul.dev"
  else
    default from: ENV["SMTP_FROM"] || "#{Setting["mailer_from_name"]} <#{Setting["mailer_from_address"]}>"
  end
  layout "mailer"
end
