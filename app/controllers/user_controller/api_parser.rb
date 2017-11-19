class UserController
  class ApiParser
    def initialize(userName)
      @userName = userName
    end

    def getSubscriptions
      subscribes = getSubscribes(getUser)
      subscriptions = Array.new(subscribes.size)

      i = 0
      subscribes.each do |subscribe|
        subscriptions[i] = Subscription.find_by_subscription_id(subscribe.subscription_id)
        i += 1
      end
      return subscriptions
    end

    def getCategories
      categories = Subscription.categories.uniq.pluck(:category)
    end

    def getSubscriptionsByCategory(category)
      subscriptions = Subscription.where(:category => category)
      return subscriptions
    end

    def getSubscriptionsByName(names)
      subscriptions = Array.new
      names.each do |name|
        subscription = Subscription.where(:name => name)
        subscription.each do |s|
          subscriptions.push(s)
        end
      end
      return subscriptions
    end

    def getSubscriptionsBySearch(name)
      subscriptions = Subscription.search(name)
      return subscriptions
    end

    private
      def getUser
        return User.find_by_user_name(@userName).id
      end

      def getSubscribes(userId)
        return User.find_by_user_id(userId).subscribes
      end
  end
end
