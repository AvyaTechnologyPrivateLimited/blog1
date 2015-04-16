class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable
  
  attr_accessor :login, :avatar_cache

  paginates_per 10

  validates :first_name, :last_name, :presence => true
  validates :username, :presence => true, :uniqueness => true

  has_many  :comments
  has_many  :posts, :dependent => :destroy
  has_many  :fist_bumps
  mount_uploader :avatar, AvatarUploader

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(email: conditions["email"]).first
    end
  end 

  def self.user_serach_by_keyword(keyword)
    result = []
    keyword.split(" ").each do |word|
      result << where(
        "lower(username) like ? "+
        "or "+
        "lower(first_name) like ? "+
        "or "+
        "lower(last_name) like ?",
        '%'+ word.downcase+'%',
        '%'+word.downcase+'%',
        '%'+word.downcase+'%'
      )
    end
    return result.flatten
  end

  def full_name
    "#{first_name}" + " " + "#{last_name}"
  end    

end
