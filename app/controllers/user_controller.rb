# if you want to use it in the views we need to add character @
class UserController < ApplicationController
  layout false

  require 'NewsAPI_Source'
  require 'NewsAPI_Article'

  include HTTParty
  include NewsAPI_Source
  include NewsAPI_Article

  # Prepare Articles to be rendered by the view.
  def ActionOne
    # Variables used by the view to display articles
    @apiParser = ApiParser.new(session[:user_name])
    @user_subscriptions = @apiParser.getSubscriptions
    @categories = getCategories
    @sources = Array.new
    @articles = Array.new

    # Prepare Articles by Search
    if params.has_key?('search')
      prepareArticlesBySearch

    # Prepare Articles by Category
    elsif params.has_key?('category')
      subscriptions = @apiParser.getSubscriptionsByCategory(params['category'])

      subscriptions.each do |subscription|
        prepareArticlesBySource(subscription.source_id)
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
          prepareArticlesBySource(source)
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
      text = article['title'] + article['description']
      @articles.push(Article.new(href,imgsrc,id,text))
    end
  end

  # Filters articles by search and adds them to the array
  def prepareArticlesBySearch
    search_result
    @categories.each do |category|
      if params[:search] == category then
        search_result = @apiParser.getSubscriptionsByCategory(category)
      end
    end

    if search_result.empty?
      search_result = @apiParser.getSubscriptionsBySearch(params['search'])
    end

    search_result.each do |source|
      prepareArticlesBySource(source)
    end
    return search_result
  end
end
