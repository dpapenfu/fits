# == Schema Information
#
# Table name: users
#
#  id                             :integer          not null, primary key
#  email                          :string
#  mobile                         :string
#  own_photos_count               :integer
#  password_digest                :string
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
  has_secure_password
  mount_uploader :user_profile_pic, ImageUploader
end
