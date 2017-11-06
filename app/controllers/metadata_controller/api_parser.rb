class MetadataController
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

    private
      def getUser
        return User.find_by_user_name(@userName).id
      end

      def getSubscribes(userId)
        return User.find_by_user_id(userId).subscribes
      end
  end
end
