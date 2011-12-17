class Topic < ActiveRecord::Base
  attr_accessible :title, :user_id, :forum_id

  has_many   :posts, :dependent => :destroy
  belongs_to :forum
  belongs_to :user

  validates  :title,    :presence => true,
                        :length   => { :maximum => 80 }
  validates  :user_id,  :presence => true
  validates  :forum_id, :presence => true

end
