class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.belongs_to :snapshot
      t.timestamps
    end
  end
end
