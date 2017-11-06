# if you want to use it in the views we need to add character @
class UserController < ApplicationController
  #require 'DesignPatterns'
  #require 'NewsAPI'
  #require 'NewsAPI2'
  #include DesignPatterns
  require 'Article'
  require 'APIFunctions'
  require 'NewsAPI_Source'
  require 'NewsAPI_Article'

  include APIFunctions
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
    @categories = getCategories
    @sources = getSources
    @articles = Array.new

    if params.has_key?('category')
      puts "category form detected. the category is: #{params['category']}"

      puts "generating list of articles for specific category"

    elsif params.has_key?('sources')
      puts "sources category found, printing list of categories"
      params['sources'].each do |source|
        puts source
      end

    else
      href = "./User/ActionOne"
      imgsrc = "http://www.gettyimages.ca/gi-resources/images/Embed/new/embed2.jpg"
      article_id = 1
      text = "Welcome to newsfeed me, Please select category or sources"
      @articles.push(Article.new(href,imgsrc,article_id,text))

    end
    puts "printing param keys2"


    # function returns list of articles id's by category;
    print getSourcesByCategory('business').class


    #make api call. get result;

    @categories = getCategories
    @sources = getSources

  end

end
