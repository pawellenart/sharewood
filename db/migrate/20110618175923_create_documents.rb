class CreateDocuments < ActiveRecord::Migration
  def self.up
    create_table :documents do |t|
      t.string :title
      t.text :description
      t.references :user
      t.references :project

      t.timestamps
    end
  end

  def self.down
    drop_table :documents
  end
end
