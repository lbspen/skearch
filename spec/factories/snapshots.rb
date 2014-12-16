# == Schema Information
#
# Table name: snapshots
#
#  id         :integer          not null, primary key
#  content    :text
#  created_at :datetime
#  updated_at :datetime
#

FactoryGirl.define do
  factory :snapshot do |f|
    f.content '["document 1", "document 2"]'
  end

  factory :invalid_snapshot, parent: :snapshot do |f|
    f.content nil
  end
end
