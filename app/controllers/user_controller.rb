# if you want to use it in the views we need to add character @
class UserController < ApplicationController
  layout 'user'

  include HTTParty
  $favourite = false

  def index
    $favourite = false
    redirect_to(:action => 'display')
  end

  def isFavourite
    status = Favourite.find_by_article_id(params[:id].to_i)
    if status.nil?
      fav = Favourite.new(:user_id => session[:userid],
        :article_id => params[:id].to_i)
      if fav.save
        # Do Nothing
      else
        flash[:notice] = "Sorry, unable to add to favourites."
      end
    else
      if status.destroy
        # Do nothing
      else
        flash[:notice] = "Sorry, unable to update the favourites"
      end
    end
    redirect_to(:action => 'display')
  end

  def favourites
    $favourite = true
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
      if !@user_subscriptions.nil?
        @user_subscriptions.each do |subscription|
          if params['category'].include? subscription.category
            prepareArticlesBySource(subscription.source_id)
          end
        end
      end

    # Prepare Articles by sources
    elsif params.has_key?('sources')
      subscriptions = @apiParser.getSubscriptionsByName(params['sources'])
      if !subscriptions.nil?
        subscriptions.each do |subscription|
          prepareArticlesBySource(subscription.source_id)
        end
      end

    # Prepare Articles by favourites
    elsif $favourite
      prepareArticlesByFavourites

    # Prepare Articles by User Subscriptions
    else
      if @user_subscriptions.empty?

      else
        @user_subscriptions.each do |source|
          prepareArticlesBySource(source.source_id)
        end
      end
    end
    $favourite = false
  end

  # Filters articles by sources and adds them to the array
  def prepareArticlesBySource(source)
    articles_from_database = @apiParser.getArticles(source)
    if !articles_from_database.nil?
      articles_from_database.each do |article|
        text = ""
        if !article.title.nil?
          text += article.title + "\n"
        end

        if !article.description.nil?
          text += article.description + "\n"
        end

        @articles.push(UserProfile.new(article.url, article.urlToImage,
          article.article_id, text))
      end
    end
  end

  # Filters articles by search and adds them to the array
  def prepareArticlesBySearch
    search_result = @apiParser.getSubscriptionsBySearch(params['search'])
    if !search_result.nil?
      search_result.each do |article|
        text = ""
        desc = ""
        if !article.title.nil?
          text += article.title + "\n"
        end

        if !article.description.nil?
          text += article.description + "\n"
        end
        @articles.push(UserProfile.new(article.url, article.urlToImage,
          article.article_id, text))
      end
    end
  end

  # Filter articles by favourites and add them to the array
  def prepareArticlesByFavourites
    articleIds = Favourite.select(:article_id).where(:user_id => session[:userid])
    articles = @apiParser.getArticlesByIds(articleIds)
    if !articles.empty?
      articles.each do |article|
        text = ""
        if article.has_attribute?(:title)
          text += article[:title] + "\n"
        end

        if article.has_attribute?(:description)
          text += article[:description] + "\n"
        end

        @articles.push(UserProfile.new(article[:url], article[:urlToImage],
          article[:article_id], text))
      end
    end
  end
end
