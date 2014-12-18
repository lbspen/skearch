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

class Document < ActiveRecord::Base
  belongs_to :snapshot

  validates :snapshot, presence: true
  validate  :terms_must_not_be_nil

  def initialize(content)
    super()
  end

private

  def terms_must_not_be_nil
    errors.add(:terms, 'cannot be nil') if self.terms.nil?
  end
end
