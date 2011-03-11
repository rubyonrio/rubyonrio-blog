class Member < ActiveRecord::Base
  validates_presence_of :username

  def user
    @user ||= GitHub::API.user(self.username)
  end

  def name
    user.name
  end

  def email
    user.email
  end

  def company
    user.company
  end

  def blog
    user.blog
  end

  def github
    "http://github.com/#{user.login}"
  end

  def repositories
    user.repositories
  end

  def commits
    user.commits
  end

  def avatar(size=40)
    "http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(email)}?s=#{size}"
  end

  def location
    user.location
  end
end

