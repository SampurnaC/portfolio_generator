SimpleCov.start "rails" do
  # Ignore helpers
  add_filter "/spec/rails_helper.rb"
  add_filter "/app/mailers/application_mailer.rb"
  add_filter "/app/jobs/application_job.rb"
end
