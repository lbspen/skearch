# == Schema Information
#
# Table name: documents
#
#  id          :integer          not null, primary key
#  snapshot_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

require 'spec_helper'

RSpec.describe Document, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
