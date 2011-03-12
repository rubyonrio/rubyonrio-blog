class Member < ActiveRecord::Base
  validates :username, :presence => true, :uniqueness => true
  before_save :github_username, :message => 'Invalid github username'

  def user
    @user ||= GitHub::API.user(self.username)
  end

  def name
    user.name || user.login
  end

  def email
    user.email || ''
  end

  def company
    user.company || ''
  end

  def blog
    user.blog || ''
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
    user.location  || 'No location'
  end

  def isadmin?
    self.admin
  end

  def twitter_username
    return self.twitter unless self.twitter.blank?
    self.username
  end

  def destroy_with_undo
    transaction do
      self.destroy
      DeleteMemberUndo.create_undo(self)
    end
  end

  private
  def github_username
    begin
      @user = GitHub::API.user(username)
    rescue
      return false
    end
    true if name
  end
end

