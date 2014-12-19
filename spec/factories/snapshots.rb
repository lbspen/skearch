# == Schema Information
#
# Table name: snapshots
#
#  id         :integer          not null, primary key
#  contents   :text             default([]), is an Array
#  created_at :datetime
#  updated_at :datetime
#

FactoryGirl.define do
  factory :snapshot do |f|
    f.contents nil
  end

  factory :snapshot_after_crawl, parent: :snapshot do |f|
    f.contents ["document1", "document2"]
  end
end
