class Forum < ActiveRecord::Base
  attr_accessible :title, :user_id

  has_many   :topics, :dependent => :destroy
  belongs_to :user

  validates  :title,   :presence => true,
                       :length   => { :maximum => 80 }
  validates  :user_id, :presence => true

end
