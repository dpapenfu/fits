# == Schema Information
#
# Table name: users
#
#  id                             :integer          not null, primary key
#  email                          :string
#  mobile                         :string
#  own_photos_count               :integer
#  password_digest                :string
#  private                        :boolean
#  received_follow_requests_count :integer
#  sent_follow_requests_count     :integer
#  user_profile_pic               :string
#  username                       :string
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#
class User < ApplicationRecord
  validates :email, :uniqueness => { :case_sensitive => false }
  validates :email, :presence => true
  validates(:username, { :presence => true })
  validates(:username, { :uniqueness => true })

  has_secure_password
  mount_uploader :user_profile_pic, ImageUploader

  has_many(:likes, { :class_name => "Like", :foreign_key => "user_id", :dependent => :destroy })
  has_many(:comments, { :class_name => "Comment", :foreign_key => "commenter_id", :dependent => :destroy })
  has_many(:sent_follow_requests, { :class_name => "MootsRequest", :foreign_key => "sender_id", :dependent => :destroy })
  has_many(:received_follow_requests, { :class_name => "MootsRequest", :foreign_key => "recipient_id", :dependent => :destroy })
  has_many(:own_photos, { :class_name => "Photo", :foreign_key => "owner_id", :dependent => :destroy })
  has_many(:following, { :through => :sent_follow_requests, :source => :recipient })
  has_many(:followers, { :through => :received_follow_requests, :source => :sender })
  has_many(:liked_photos, { :through => :likes, :source => :photo })
  has_many(:feed, { :through => :following, :source => :own_photos })
  has_many(:activity, { :through => :following, :source => :liked_photos })

end
