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
    f.content nil
  end

  factory :snapshot_after_crawl, parent: :snapshot do |f|
    f.content '["document1", "document2"]'
  end
end
