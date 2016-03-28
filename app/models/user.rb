class User < ActiveRecord::Base
  belongs_to :messageable_user, polymorphic: true
  acts_as_messageable
end
