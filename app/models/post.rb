class Post < ActiveRecord::Base
  attr_accessible :body, :user_id, :topic_id

  belongs_to :topic
  belongs_to :user

  validates  :body,     :presence => true,
                        :length   => { :maximum => 1200 }
  validates  :user_id,  :presence => true
  validates  :topic_id, :presence => true

end
