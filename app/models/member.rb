class Member < ActiveRecord::Base
  validates_presence_of :username
end

