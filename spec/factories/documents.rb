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
    transient do
      term_string "term1 term1 term2"
    end

    association :snapshot, factory: :snapshot_after_crawl
    terms { { 'term1' => 2, 'term2' => 1} }

    initialize_with { new(term_string) }
  end
end

