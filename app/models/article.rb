class Article < ActiveRecord::Base
  include HTTParty

  belongs_to :subscriptions
  has_many :users

  scope :search_by_publishedBefore, lambda { |query|
    where("publishedAt <= ?", "%#{query}%")
  }

  # source->[article]

  # Update the articles in the database every time period
  def self.updateArticles
    self.deleteArticles
    subscriptions = Subscription.all
    subscriptions.each do |subscription|
      self.update(subscription.source_id)
    end
  end

  # Delete articles not subscribed
  def self.deleteArticles
    articles = Article.all
    articles.each do |article|
      if Favourite.find_by_article_id(article.article_id).nil?
        Article.destroy(article.article_id)
      end
    end
  end

  # Retrieve 20 or less articles from newsapi
  def self.update(source)
    uri = "https://newsapi.org/v2/everything?sources="
    uri.concat(source)
    uri.concat("&sortBy=popularity&apiKey=f52e670563fe4fe5b0d06da57eb0bbf6")
    # puts "#{uri}"
    data = HTTParty.get(uri)
    parsed_data = data.parsed_response
    if parsed_data['status'].eql? 'ok'
      self.addToDatabase(parsed_data)
    end
  end

  # Add the retrieved articles to the database
  def self.addToDatabase(parsed_data)
    parsed_data['articles'].each do |article|
      if Article.find_by_title(article['title']).nil?
        new_article = Article.new(:source_id => article['source']['id'],
          :source_name => article['source']['name'],
          :author => article['author'],
          :title => article['title'],
          :description => article['description'],
          :url => article['url'],
          :urlToImage => article['urlToImage'],
          :publishedAt => article['publishedAt'])

        if new_article.save
          # Do nothing
        end
      end
    end
  end
end
