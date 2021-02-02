class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable and :registerable

  # We have removed :registrable to not allow the user to sign up alone
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  acts_as_token_authenticatable

  has_many :ppsps
  belongs_to :company
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :admin, inclusion: { in: [true, false] }
  attr_accessor :user_update

  validate :secure_password, unless: :user_update?

  def full_name
    "#{first_name} #{last_name}"
  end

  def user_update?
    user_update == true
  end

  def secure_password
    if (password =~ /[a-z]/).blank? || (password =~ /[A-Z]/).blank? || (password =~ /[0-9]/).blank? || (password =~ /[^A-Za-z0-9]/).blank?
      errors.add(:password, 'doit contenir au moins une lettre miniscule, une lettre majuscule, un numéro et un caractère spécial')
    end
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
