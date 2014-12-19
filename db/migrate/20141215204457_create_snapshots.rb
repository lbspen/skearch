class CreateSnapshots < ActiveRecord::Migration
  def change
    create_table :snapshots do |t|
      t.text :contents, array: true, default: '{}'
      t.timestamps
    end
  end
end
