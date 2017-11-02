
class HTMLObject
  Ar1
  def intialize
    Ar1 = 1
  end

  def talk_about_me
        puts("Hello I am ")
  end

end

class UserController < ApplicationController
  require 'DesignPatterns'
  include DesignPatterns

  require 'HTML_Object'
  include HTMLObject

  def index
     #Index code
  end

  def show
     #Show code
  end

  def ActionOne
    htmlObject = HTMLObject.new
    #htmlObject.talk_about_me
    #_hello
  end

end
