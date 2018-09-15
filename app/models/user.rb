class User < ActiveRecord::Base
  has_secure_password
  has_many :recipes
  validates :name, presence: true
  validates :email, presence: true
  validates :email, uniqueness: true
  validates_format_of :email, :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
  validates :password_confirmation, presence: true
  validates :password, length: { minimum: 8 }

  def slug
    value = self.email.mb_chars.normalize(:kd).gsub(/[^\x00-\x7F]/n, '').to_s
    value.gsub!(/[']+/, '')
    value.gsub!(/\W+/, ' ')
    value.strip!
    value.downcase!
    value.gsub!(' ', '-')
    value
  end

  def self.find_by_slug(slug)
    self.find { |obj| obj.slug == slug }
  end

end
