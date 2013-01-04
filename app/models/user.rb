class User < ActiveRecord::Base

  #####################################
  ## DEVISE BLOCK

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :token_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  ## END DEVISE BLOCK
  #####################################

  has_many :tags
  has_many :messages

  attr_accessible :display_name
  validates :display_name, :presence => true

  def devices
    Device.find(self.id)
  end

  def register_device(reg_id)
    # TODO: verify reg_id
    Device.register(self.id, reg_id)
  end

  def unregister_device(reg_id)
    Device.unregister(self.id, reg_id)
  end

  def send_message(tag, contents)
    msg = tag.user.messages.new(:contents => contents)
    msg.sender_id = self.id

    return msg.save
  end
end
