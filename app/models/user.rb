class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :first_name, :last_name, :username, :email, :password, :password_confirmation, :active

  has_many  :forumns
  has_many  :topics
  has_many  :posts

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :first_name, :presence     => true,
                         :length       => { :maximum => 25 }
  validates :last_name,  :presence     => true,
                         :length       => { :maximum => 25 }
  validates :username,   :presence     => true,
                         :length       => { :maximum => 20 },
                         :uniqueness   => { :case_sensitive => false }
  validates :email,      :presence     => true,
                         :format       => { :with => email_regex },
                         :uniqueness   => { :case_sensitive => false }
  validates :password,   :presence     => true,
                         :confirmation => true,
                         :length       => { :within => 6..40 }

  before_save :encrypt_password

# Return true if the user's password matches the submitted password
  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end

  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil  if user.nil?
    return user if user.has_password?(submitted_password)
  end

  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end

  private

    def encrypt_password
      self.salt = make_salt unless has_password?(password)
      self.encrypted_password = encrypt(password)
    end

    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end

    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end

end
