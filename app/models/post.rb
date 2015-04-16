class Post < ActiveRecord::Base

  validates :contents, :user_id, :presence => true
  validates :title, :presence => true, :uniqueness => true
  
  has_many  :comments, :dependent => :destroy
  has_many  :fist_bumps, :dependent => :destroy
  belongs_to :user

  paginates_per 10

  scope :published_posts, ->{where(:is_published => true).order("updated_at DESC").limit(5)}

  def post_like_count
    count = self.fist_bumps.where(:is_like => true).count
    count == 0 ? nil : "+#{count}"
  end

  def is_owner?(current_user)
    user == current_user
  end
  
end
