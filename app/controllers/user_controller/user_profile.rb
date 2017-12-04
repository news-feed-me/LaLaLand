#this class outputs the the html which corresponds to the article.

# YOU NEED THIS;
class UserController
  class UserProfile
    attr_reader :href, :src, :id, :text

    # need to separate input with commas
    def initialize(href, src, id, text)
      @href = href
      @src = src
      @id = id
      @text = text
    end

    def outputHTML
      htmlOutput = "<div class=\"article\">"+"<a href=\"#{@href}\" id=\"#{@id}\">\n"+
      "   <div class=\"article_image\">\n"+
      "     <img src=\"#{@src}\">\n </div>
      <div class=\"article_text\">"+
              "#{@text}\n </div></a></div> "
      return htmlOutput
    end

    def shareButtons
      share = "<div class=\"share-buttons\">"+
      "social_share_button_tag(#{@text}, :url => #{@href}, :image => #{@src}) </div>"
      return share
    end

    def facebookShare
      button = "<div class=\"fb-share-button\" data-href=\"#{href}\" data-layout=\"button_count\" data-size=\"small\" data-mobile-iframe=\"true\"><a class=\"fb-xfbml-parse-ignore\" target=\"_blank\" href=\"https://www.facebook.com/sharer/sharer.php?u=https%3A%2F%2Fdevelopers.facebook.com%2Fdocs%2Fplugins%2F&amp;src=sdkpreparse\">Share</a></div>"
    end

    def link
      return @href
    end

    def img
      return @src
    end

    def title
      return @text
    end
  end
end
