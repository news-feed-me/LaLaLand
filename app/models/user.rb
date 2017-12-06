class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_secure_password
  has_many :subscribes
  has_many :subscriptions, :through => :subscribes

  has_many :favourites
  has_many :articles, :through => :favourites

  validates_presence_of :first_name, :last_name

  validates_presence_of :user_name
  validates_length_of :user_name, :within => 5..255
  validates_uniqueness_of :user_name

  validates_length_of :first_name, :maximum => 255
  validates_length_of :last_name, :maximum => 255

  validates_presence_of :email
  validates_length_of :email, :maximum => 255
  validates_uniqueness_of :email
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i ,
                      :message => "format: example@feedme.ca"#proper email format

  #validates_presence_of :password
  validates_length_of :password, :within => 8..255
  validates_confirmation_of :password
  #validates_presence_of :password_confirmation

  validates_presence_of :birth_date
  #validates_format_of :birth_date, :with => /\d{2}\/\d{2}\/\d{4}/,


  validates_length_of :country, :maximum => 255

  #validates_presence_of :subscribes
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ?
  BCrypt::Engine::MIN_COST :
                              BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

    
end
