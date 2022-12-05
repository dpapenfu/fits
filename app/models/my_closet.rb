# == Schema Information
#
# Table name: my_closets
#
#  id         :integer          not null, primary key
#  caption    :string
#  clothing   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
class MyCloset < ApplicationRecord
  mount_uploader :clothing, ImageUploader
  belongs_to(:user, { :required => true, :class_name => "User", :foreign_key => "user_id" })
  has_many(:follow_requests_sent, { :through => :user, :source => :sent_follow_requests })
end
