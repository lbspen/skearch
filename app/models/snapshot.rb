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
  validates :content, presence: true

  before_create :do_crawl

  protected

  def do_crawl
    crawler = Crawler.new
    crawler.crawl
  end
end
