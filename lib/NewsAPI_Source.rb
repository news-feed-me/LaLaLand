module NewsAPI_Source

  #() -> [(Sources,SourceName)]
  def getIdNameHash
    id_nameHash = Hash.new
    apiCallSources = HTTParty.get("https://newsapi.org/v2/sources?apiKey=f52e670563fe4fe5b0d06da57eb0bbf6")

    apiCallSources.parsed_response['sources'].each do |source|
      id = source['id']
      name = source['name']
      id_nameHash.store(id,name)
    end
    return  id_nameHash
  end

  #() -> [Sources]
  def getSources
    idArray = Array.new
    apiCallSources = HTTParty.get("https://newsapi.org/v2/sources?apiKey=f52e670563fe4fe5b0d06da57eb0bbf6")

    apiCallSources.parsed_response['sources'].each do |source|
      id = source['id']
      name = source['name']
      idArray.push(id)
    end
    return idArray
  end

  #This is list of id's by
  # category -> [Sources]
  def getSourcesByCategory(category)
    idArray = Array.new
    if getCategories.include? category
      getIdNameHash.each_key do |key|
        idArray.push(key)
      end
    end
    return idArray
  end
end
