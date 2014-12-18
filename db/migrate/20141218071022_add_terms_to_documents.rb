class AddTermsToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :terms, :hstore
  end
end
