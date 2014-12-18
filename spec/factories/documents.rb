# == Schema Information
#
# Table name: documents
#
#  id          :integer          not null, primary key
#  snapshot_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#  terms       :hstore
#

FactoryGirl.define do
  factory :document do
    association :snapshot, factory: :snapshot_after_crawl
    terms { { 'term1' => 2, 'term2' => 1} }
  end
end
