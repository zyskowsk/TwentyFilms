class User < ActiveRecord::Base
  attr_accessor :password, :password_confirmation
  attr_accessible :email, :name, :password_digest, :profile, :session_token, 
                  :username

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  validates :email, :format => { :with => VALID_EMAIL_REGEX,
                                 :message => "Please give valid email" }

  validates :email, :name, :username, :session_token, :presence => true
  validates :email, :uniqueness => { :message => "Email already taken" }
  validates :username, :uniqueness => { :message => "Username already taken" }
  validates :password, :length => { :minimum => 6, :allow_nil => true },
                       :on => :create

  validate :confirm_password, :on => :create

  def self.find_by_credentials(login, password)
    user = User.find_by_username(login)
    user ||= User.find_by_email(login)

    return nil if user.nil?

    user.is_correct_password?(password) ? user : ni;
  end

  def is_correct_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64(16)
    self.save!
  end

  private 
    def confirm_password 
      @password == @password_confirmation
      self.errors.full_messages << "Passwords do not match"
    end
end
