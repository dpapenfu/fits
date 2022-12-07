# == Schema Information
#
# Table name: fit_checks
#
#  id           :integer          not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  my_closet_id :integer
#  user_id      :integer
#
class FitCheck < ApplicationRecord
  belongs_to(:user, { :required => true, :class_name => "User", :foreign_key => "user_id" })
  belongs_to(:my_closet, { :required => true, :class_name => "MyCloset", :foreign_key => "my_closet_id"})
end
