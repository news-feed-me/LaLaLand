class UserController
  class ApiParser
    def initialize(userName)
      @userName = userName
    end

    def getSubscriptions
      subscribes = getSubscribes(getUser)
      subscriptions = Array.new(subscribes.size)

      i = 0
      if !subscribes.nil?
        subscribes.each do |subscribe|
          subscriptions[i] = Subscription.find_by_subscription_id(subscribe.subscription_id)
          i += 1
        end
      end
      return subscriptions
    end

    def getCategories
      categories = Subscription.uniq.pluck(:category)
      return categories
    end

    def getSubscriptionsByCategory(category)
      subscriptions = Subscription.where(:category => category)
      return subscriptions
    end

    def getSubscriptionsByName(names)
      subscriptions = Array.new
      if !names.nil?
        names.each do |name|
          subscription = Subscription.where(:name => name)
          if !subscription.nil?
            subscription.each do |s|
              subscriptions.push(s)
            end
          end
        end
      end
      return subscriptions
    end

    def getSubscriptionsBySearch(name)
      articles = Array.new
      categories = Subscription.searchCategory(name)
      sources_by_name = Subscription.searchName(name)
      sources_by_id = Subscription.searchID(name)

      # Retrieve articles from database if searched by category.
      if !categories.empty?
        categories.each do |category|
          articles += getArticles(category.source_id)
        end
      # Retrieve articles from database if searched by source.
    elsif !sources_by_name.empty?
        sources_by_name.each do |source|
          articles += getArticles(source.source_id)
        end
      elsif !sources_by_id.empty?
        sources_by_id.each do |source|
          articles += getArticles(source.source_id)
        end
      # Search articles through newsapi q search parameter.
      else
        uri = "https://newsapi.org/v2/everything?q="
        uri.concat(name)
        uri.concat("&sortBy=popularity&apiKey=f52e670563fe4fe5b0d06da57eb0bbf6")
        data = HTTParty.get(uri)
        parsed_data = data.parsed_response

        if parsed_data['status'].eql? 'ok'
          if parsed_data.has_key? 'articles' && !parsed_data['articles'].nil?
            parsed_data['articles'].each do |article|
              articles.push(article)
            end
          end
        end
      end
      return articles
    end

    def getArticlesByIds(articleIds)
      articles = Array.new
      if !articleIds.empty?
        articleIds.each do |article|
          articles += Article.find_by_article_id(article.article_id)
        end
      end
      return articles
    end

    def getArticles(source)
      return Article.where(:source_id => source)
    end

    private
      def getUser
        return User.find_by_user_name(@userName).user_id
      end

      def getSubscribes(userId)
        return User.find_by_user_id(userId).subscribes
      end
  end
end
