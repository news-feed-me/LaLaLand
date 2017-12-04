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
      return "<a href=\"#{@href}\" id=\"#{@id}\" target=\"_blank\">\n"+
      "<div class=\"article_image\"> \n" + "<img src=\"#{@src}\">\n </div>
      <div class=\"article_text\">" + "#{@text}\n </div></a>"
    end

    def favourites
      if getStatus
        return "<a href=\"\\user\\favourites\">
        <img src=\"https://png.icons8.com/add-to-favorites/ultraviolet/50/000000\"></a>"
      else
        return "<a href=\"\\user\\favourites\">
        <img src=\"https://png.icons8.com/add-to-favorites/ios7/50/000000\"></a>"
      end
    end

    def share_buttons
      "<a href=\"https://www.facebook.com/sharer/sharer.php?u=#{@href}\" target=\"_blank\">
      <img src=\"https://png.icons8.com/facebook/color/50/000000\"></a>
      <a href=\"https://twitter.com/intent/tweet?url=#{@href}\" target=\"_blank\">
      <img src=\"https://png.icons8.com/twitter/color/50/000000\"></a>
      <a href=\"https://plus.google.com/share?url=#{@href}\" target=\"_blank\">
      <img src=\"https://png.icons8.com/google-plus/color/50/000000\"></a>"
    end

    def getStatus
      if Favourite.find_by_article_id(@id).nil?
        return false
      else
        return true
      end
    end
  end
end
