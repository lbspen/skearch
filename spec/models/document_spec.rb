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

require 'spec_helper'

RSpec.describe Document, :type => :model do
  it 'belongs to Snapshot' do
    r = Document.reflect_on_association(:snapshot)
    expect(r.macro).to eq(:belongs_to)
  end

  it 'is invalid without a snapshot' do
    expect(build(:document, snapshot: nil)).not_to be_valid
  end

  it 'has a valid factory' do
    expect(create(:document)).to be_valid
  end

  it 'is invalid with nil terms' do
    expect(build(:document, terms: nil)).not_to be_valid
  end

  it 'is valid with empty terms' do
    expect(build(:document, terms: {})).to be_valid
  end

  context 'term counts' do
    let(:contents) do
      "Because I'm happy " \
      "Clap along if you feel like a room without a roof " \
      "Because I'm happy " \
      "Clap along if you feel like happiness is the truth " \
      "Because I'm happy " \
      "Clap along if you know what happiness is to you " \
      "Because I'm happy " \
      "Clap along if you feel like that's what you wanna do"
    end

    let(:doc) { Document.new(contents) }

    it 'generates term counts from constructor parameter' do
      expect(doc.terms['happy']).to eq "4"
      expect(doc.terms['roof']).to eq "1"
    end

    it 'sorts term counts descending by count' do
      last_count = doc.sorted_frequencies.first.second
      doc.sorted_frequencies.each do |pair|
        expect(pair.second).to be <= last_count
        last_count = pair.second
      end
    end
  end
end

