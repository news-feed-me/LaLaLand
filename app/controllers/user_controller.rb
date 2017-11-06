# if you want to use it in the views we need to add character @
class UserController < ApplicationController
  layout false
  #require 'DesignPatterns'
  #require 'NewsAPI'
  #require 'NewsAPI2'
  #include DesignPatterns
  require 'Article'
  require 'NewsAPI_Source'
  require 'NewsAPI_Article'

  include HTTParty
  include NewsAPI_Source
  include NewsAPI_Article


  def index
    @categories = getCategories
    @sources = getSources

  end

  def show

  end

  # this is just custom made action for testing purposes
  # the code included here can and should be refactored into a new
  # action/s.
  def ActionOne
    @apiParser = ApiParser.new(session[:user_name])
    @subscriptions = @apiParser.getSubscriptions
    @categories = getCategories
    @sources = Array.new

    @subscriptions.each do |subscription|
      @sources.push(subscription.source_id)
    end

    puts @sources

    @articles = Array.new

    if params.has_key?('category')
      puts "category form detected. the category is: #{params['category']}"
      idsByCategory = getSourcesByCategory(params['category'])
      newsArticles = getNewsBySourceIDs(idsByCategory,5)
      i = 0
      newsArticles.each do |article|
        href = article['url']
        imgsrc = article['urlToImage']
        text = article['title']
        @articles.push(Article.new(href,imgsrc,id,text))
      end

    elsif !params || params.has_key?('sources')

      puts "sources category found, printing list of categories"
      number_of_sources = params['sources'].length
      puts "number of sources #{number_of_sources}"

      @subscriptions.each do |source|
        articles = getNewsBySourceID(source.source_id)
        i = 0
        articles.each do |article|

          href = article['url']
          imgsrc = article['urlToImage']
          id = i
          text = article['title'] <<  article['description']
          puts text

          @articles.push(Article.new(href,imgsrc,id,text))
        end
      end

    else
      href = "./User/ActionOne"
      imgsrc = "http://www.gettyimages.ca/gi-resources/images/Embed/new/embed2.jpg"
      article_id = 1
      text = "Welcome to newsfeed me, Please select category or sources"
      @articles.push(Article.new(href,imgsrc,article_id,text))

    end


  end

end
