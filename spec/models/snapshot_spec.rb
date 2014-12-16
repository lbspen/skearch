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
  it 'has a valid factory' do
    expect(create(:snapshot)).to be_valid
  end

  it 'is invalid without content' do
    expect(build(:snapshot, content: nil)).not_to be_valid
  end
end
