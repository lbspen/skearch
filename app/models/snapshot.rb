# == Schema Information
#
# Table name: snapshots
#
#  id         :integer          not null, primary key
#  contents   :text             default([]), is an Array
#  created_at :datetime
#  updated_at :datetime
#

class Snapshot < ActiveRecord::Base

  has_many :documents, dependent: :destroy
  validates :contents, presence: true

  def crawl
    self.contents = Crawler.new.crawl
    return if self.contents.nil?
    self.contents.each do |snippet|
      self.documents << Document.new(snippet)
    end
  end

  def top_terms
    term_totals = {}
    self.documents.each do |doc|
      term_totals = term_totals.merge(doc.terms) do |_, oldval, newval|
        (Integer(newval) + Integer(oldval)).to_s
      end
    end
    term_totals.each do |k, v|
      count = Integer(v)
      count > 1 ? term_totals[k] = Integer(v) : term_totals.delete(k)
    end.sort_by { |k, v| v }.reverse.map { |pair| pair.first }
  end
end
