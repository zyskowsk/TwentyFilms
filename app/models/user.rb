require 'bcrypt'

class User < ActiveRecord::Base
  attr_accessor :password, :password_confirmation
  attr_accessible :email, :name, :password_digest, 
                  :password, :password_confirmation, 
                  :profile, :session_token, :username

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  validates :email, :format => { :with => VALID_EMAIL_REGEX,
                                 :message => "not valid" }
  validates :email, :name, :username, :session_token, :presence => true
  validates :password, :password_confirmation, :presence => true, :on => :create
  validates :email, :uniqueness => { :message => "already taken" }
  validates :username, :uniqueness => { :message => "already taken" }
  validates :password, :length => { :minimum => 6, :allow_nil => true },
                       :on => :create

  validate :confirm_password, :on => :create

  before_create :encrypt_password
  before_save :set_gravatar_id
  after_initialize :ensure_session_token

  has_many :films, :through => :film_choices, :order => 'film_choices.ord'
  has_many(
    :film_choices,
    :class_name => "FilmChoice",
    :foreign_key => :user_id
  )

  has_many( 
    :incoming_follows,
    :class_name => "Following",
    :foreign_key => :followee_id
  )

  has_many( 
    :outgoing_follows,
    :class_name => "Following",
    :foreign_key => :follower_id
  )

  has_many :followed_users, :through => :outgoing_follows, :source => :followee
  has_many :followers, :through => :incoming_follows, :source => :follower

  def self.find_by_credentials(login, password)
    user = User.find_by_username(login)
    user ||= User.find_by_email(login)

    return nil if user.nil?

    user.is_correct_password?(password) ? user : nil;
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def encrypt_password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_correct_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def set_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
  end

  private 
    def confirm_password 
      errors.add(:passwords, "don't match") unless 
      @password == @password_confirmation
    end

    def set_gravatar_id
      self.gravatar_id = Digest::MD5.hexdigest(self.email.downcase)
    end

    def ensure_session_token
      self.session_token ||= self.class.generate_session_token
    end
end
