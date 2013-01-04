class Tag < ActiveRecord::Base
  belongs_to :user
  has_many :messages, :order => "created_at DESC"

  attr_accessible :location

  validates :user_id, :location, :tid, :presence => true
  validates :tid, :uniqueness => true

  # Generate a unique ID for the tag on creation
  before_validation :generate_tid, :on => :create

  private
  # Callback: before_validation :generate_tid, :on => :create
  # should only be invoked once per tag creation
  def generate_tid
    # Input string we feed into the hash algorithm
    # It IS possible to have hash collisions:
    #
    # 1. Let's assume our system clock is perfect. The only way to get a hash
    # collision is to somehow submit multiple tag creation requests with the
    # same data at the exact same time. 
    #
    # 2. Now, in reference to this article...
    # infiniteundo.com/post/25326999628/falsehoods-programmers-believe-about-time
    # If our system clock screws up, hash collisions could happen in the
    # following manner:
    #   * Leap seconds
    #   * Clock somehow gets "reset" to some previous time in the past, allowing
    #     someone to replay past requests at the exact same times.
    sha1 = OpenSSL::Digest::SHA1.new
    sha1 << self.location
    sha1 << self.user_id.to_s
    sha1 << Time.now.to_f.to_s
    tid = sha1.hexdigest

    self.tid = tid
  end
end
