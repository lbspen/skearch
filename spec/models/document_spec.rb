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

   it 'is invalid without terms' do
    expect(build(:document, terms: nil)).not_to be_valid
  end
end
