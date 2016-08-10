class User < ActiveRecord::Base
  has_many :to_do_lists
end
