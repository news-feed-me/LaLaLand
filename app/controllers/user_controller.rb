# if you want to use it in the views we need to add character @
class UserController < ApplicationController
  layout 'user'

  require 'NewsAPI_Source'
  require 'NewsAPI_Article'

  include HTTParty
  include NewsAPI_Source
  include NewsAPI_Article

  def index
    redirect_to(:action => 'display')
  end

  # Prepare Articles to be rendered by the view.
  def display
    # Variables used by the view to display articles
    @user_name = session[:user_name]
    @apiParser = ApiParser.new(@user_name)
    @user_subscriptions = @apiParser.getSubscriptions
    @categories = @apiParser.getCategories
    @sources = Array.new
    @articles = Array.new

    # Prepare Articles by Search
    if params.has_key?('search')
      prepareArticlesBySearch

    # Prepare Articles by Category
    elsif params.has_key?('category')
      # subscriptions = @apiParser.getSubscriptionsByCategory(params['category'])
      #
      # subscriptions.each do |subscription|
      #   prepareArticlesBySource(subscription.source_id)
      # end
      @user_subscriptions.each do |subscription|
        if params['category'].include? subscription.category
          prepareArticlesBySource(subscription.source_id)
        end
      end

    # Prepare Articles by sources
    elsif params.has_key?('sources')
      subscriptions = @apiParser.getSubscriptionsByName(params['sources'])

      subscriptions.each do |subscription|
        prepareArticlesBySource(subscription.source_id)
      end

    # Prepare Articles by User Subscriptions
    else
      if @user_subscriptions.empty?

      else
        @user_subscriptions.each do |source|
          prepareArticlesBySource(source.source_id)
        end
      end
    end
  end

  # Filters articles by sources and adds them to the array
  def prepareArticlesBySource(source)
    articles = getNewsBySourceID(source)
    i = 0
    articles.each do |article|
      href = article['url']
      imgsrc = article['urlToImage']
      id = i
      text = article['title'] + "\n"
      if article.has_key?('description')
        text.concat(article['description'].to_s)
      end
      @articles.push(Article.new(href,imgsrc,id,text))
    end
  end

  # Filters articles by search and adds them to the array
  def prepareArticlesBySearch
    search_result = @apiParser.getSubscriptionsBySearch(params['search'])

    search_result.each do |source|
      prepareArticlesBySource(source.source_id)
    end
    return search_result
  end
end
