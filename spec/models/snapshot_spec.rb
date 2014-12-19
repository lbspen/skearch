# == Schema Information
#
# Table name: snapshots
#
#  id         :integer          not null, primary key
#  contents   :text             default([]), is an Array
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Snapshot, :type => :model do
  before do
    stub(Crawler).new.stub!.crawl { ["document1", "document2"] }
  end

  let(:snapshot) { Snapshot.new }

  it 'has a valid factory' do
    factory = build(:snapshot, attributes_for(:snapshot))
    factory.crawl
    expect(factory).to be_valid
  end

  context '#documents' do
    it 'has many Documents' do
      r = Snapshot.reflect_on_association(:documents)
      expect(r.macro).to eq(:has_many)
    end

    it 'saves crawl contents' do
      snapshot.crawl
      expect(snapshot.documents.size).to eq 2
    end

    it 'has no documents before crawl' do
      expect(snapshot.documents.size).to eq 0
    end
  end

  context '.new' do
    it 'does not create contents' do
      expect(snapshot.contents).to be_empty
    end

    it 'is invalid' do
      expect(snapshot).not_to be_valid
    end
  end

  context '#top_terms' do
    it 'combines terms from documents' do
      doc1 = create(:document)
      doc2 = create(:document)
      stub(doc1).terms { {'caramel' => '4', 'coffee' => '1'} }
      stub(doc2).terms { {'latte' => '2', 'coffee' => '2'} }
      snapshot = create(:snapshot_after_crawl)
      snapshot.documents << doc1
      snapshot.documents << doc2

      expect(snapshot.top_terms).to eq ['caramel', 'coffee', 'latte']
    end
  end

  context '#crawl' do
    let(:snapshot) { create(:snapshot_after_crawl) }

    it 'saves content' do
      expect(snapshot.contents).not_to be_nil
    end

    it 'causes validation to pass' do
      expect(snapshot).to be_valid
    end

    it 'handles crawl failure'
  end
end
