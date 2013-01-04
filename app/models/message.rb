class Message < ActiveRecord::Base
  belongs_to :tag
  belongs_to :user
  belongs_to :sender, :class_name => 'User', :foreign_key => :sender_id
  attr_accessible :contents

  validates :tag_id, :user_id, :sender_id, :presence => true
  validates :contents, :length => { maximum: 140 }

  after_create :post_to_gcm

  def post_to_gcm
  end
end
