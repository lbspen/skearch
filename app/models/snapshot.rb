# == Schema Information
#
# Table name: snapshots
#
#  id         :integer          not null, primary key
#  content    :text
#  created_at :datetime
#  updated_at :datetime
#

class Snapshot < ActiveRecord::Base

  has_many :documents
  validates :content, presence: true

  def crawl
    self.content = Crawler.new.crawl
  end

end
