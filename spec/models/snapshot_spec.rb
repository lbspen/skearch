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

RSpec.describe Snapshot, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
