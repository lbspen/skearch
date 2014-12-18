# == Schema Information
#
# Table name: snapshots
#
#  id         :integer          not null, primary key
#  content    :text
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Snapshot, :type => :model do
  before do
    stub(Crawler).new.stub!.crawl { '["document1", "document2"]' }
  end

  let(:snapshot) { Snapshot.new }

  it 'has a valid factory' do
    factory = build(:snapshot, attributes_for(:snapshot))
    factory.crawl
    expect(factory).to be_valid
  end

  context '.new' do
    it 'does not create content' do
      expect(snapshot.content).to be_nil
    end

    it 'is invalid' do
      expect(snapshot).not_to be_valid
    end
  end

  context '#crawl' do
    let(:snapshot_after_crawl) do
      snapshot.crawl
      snapshot
    end

    it 'saves content' do
      expect(snapshot_after_crawl.content).not_to be_nil
    end

    it 'causes validation to pass' do
      expect(snapshot_after_crawl).to be_valid
    end

    it 'handles crawl failure'
  end
end
