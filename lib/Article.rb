#this class outputs the the html which corresponds to the article.


# YOU NEED THIS;
class Article
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
end
