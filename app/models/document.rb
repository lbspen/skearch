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

  def initialize(contents)
    return if contents.nil?
    tokens = contents.downcase.split(' ').to_a
    term_counts = tokens.uniq.inject({}) do |hash, token|
      hash[token] = tokens.count(token) unless Stoplist::WORDS.include?(token)
      hash
    end
    super(terms: term_counts)
  end

  def sorted_frequencies
    @frequencies ||=
      self.terms.each { |k, v| self.terms[k] = Integer(v) }
        .sort_by { |k, v| v }.reverse
  end

private

  def terms_must_not_be_nil
    errors.add(:terms, 'cannot be nil') if self.terms.nil?
  end
end
