module APIFunctions
  include HTTParty


  #fuck i am reinventing teh wheel all of these functions are written;

  # You don't need this ASIM.
  
  #key must be string
  def validateHash(hash)
    if hash.class.eql? "Hash"
      return true
    else
      return false
    end
  end

  def validateKey(hash, ikey)
    hash.each_key do |key|
      if key.eql? ikey
        return true
      end
    end
    return false
  end


  def printAPICallKeys(api_response)
    if api_response.parsed_response['status'].eql? "ok"
      # this fragment of code allows you iterate throuh each keys in the API and print its value;
      api_response.parsed_response.each_key do |key|
        print key.inspect+"\n"
      end
    else
      print "incorrect Input\n"
    end
  end









#this is the end of module
end
