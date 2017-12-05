require 'rufus-scheduler'

scheduler = Rufus::Scheduler.singleton

scheduler.every '30m' do
  puts "updating articles..."
  Article.updateArticles
  puts "Updated Articles Successfully!"
end
