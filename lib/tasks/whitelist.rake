desc "Init whitelisted emails"
task :whitelist => :environment do
  Whitelist.delete_all
  %w(ex.actionmodel@gmail.com luthermoss@me.com otiswatts3@gmail.com).each do |email|
    Whitelist.create(email:email)
  end
  
end
