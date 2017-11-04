# if you want to use it in the views we need to add character @
class UserController < ApplicationController
  #require 'DesignPatterns'
  #require 'NewsAPI'
  #require 'NewsAPI2'
  #include DesignPatterns
  require 'Article'
  require 'APIFunctions'

  include APIFunctions
  include HTTParty

  def index
     #Index code
  end

  def show

  end

  # this is just custom made action for testing purposes
  # the code included here can and should be refactored into a new
  # action/s.
  def ActionOne
    # href, src, id, text

    # TODO: NEED TO CREATE COLLECTION CLASS FOR ARTICLES;
    href = "https://stackoverflow.com"
    imgsrc = "http://www.gettyimages.ca/gi-resources/images/Embed/new/embed2.jpg"
    article_id = 1
    text = "This is article text, its size has to be adjust to accomodate size format in CSS"
    @testArticle = Article.new(href,imgsrc,article_id,text)
    #make api call. get result;

    apiCallEconomist= HTTParty.get("https://newsapi.org/v1/articles?source=the-economist&sortBy=top&apiKey=43a167ad5e5943c386c72685062b81c8")
    #print apiCallEconomist.parsed_response['status']
    #printAPICallKeys(apiCallEconomist)
    @articles = []
    print "printing status of valid key"
    i = 0;
    apiCallEconomist.parsed_response['articles'].each do |article|
      articleUrl =  article['url']
      imageUrl = article['urlToImage']
      title = article['title']+":"+article['description']
      id = i
      article=Article.new(articleUrl,imageUrl,id,title)
      @articles << article
      i=i+1
    end


    #economistArticles = apiCallEconomist.parsed_response['articles']


    #iterate from for each rool and get the articles;

  end

end
