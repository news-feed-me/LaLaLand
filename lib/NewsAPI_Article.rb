#these two classes might not be needed. Functions that operate on API could be transfered to modules
module NewsAPI_Article
  include HTTParty
  # source->[article]
  def getNewsBySourceID(sourceID)
    apiCall= HTTParty.get("https://newsapi.org/v1/articles?source=#{sourceID}&sortBy=top&apiKey=43a167ad5e5943c386c72685062b81c8")
    articles = Array.new
    if(apiCall.parsed_response['status'].eql? 'ok')
      apiCall.parsed_response['articles'].each do |article|
        articles.push(article)
      end
    end
    return articles
  end

  def getExactNumberOfNewsBySourceID(sourceID,numberOfArticles)
    apiCall= HTTParty.get("https://newsapi.org/v1/articles?source=#{sourceID}&sortBy=top&apiKey=43a167ad5e5943c386c72685062b81c8")
    articles = Array.new
    i = 0
    if(apiCall.parsed_response['status'].eql? 'ok')
      apiCall.parsed_response['articles'].each do |article|
        if i >numberOfArticles
          break
        end
        articles.push(article)
      end
    end
    return articles
  end

  # need to write tests but not enough time;
  # [source]->[article]
  def getNewsBySourceIDs(sourceIDs,numberOfArticles)
    articles = Array.new
      sourceIDs.each do |source|
        puts source
        print getExactNumberOfNewsBySourceID(source,numberOfArticles).length

        articles.concat getNewsBySourceID(source)
      end
    return articles
  end
end
