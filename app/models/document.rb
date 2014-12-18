# == Schema Information
#
# Table name: documents
#
#  id          :integer          not null, primary key
#  snapshot_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Document < ActiveRecord::Base
  belongs_to :snapshot

  validates :snapshot, presence: true
end
