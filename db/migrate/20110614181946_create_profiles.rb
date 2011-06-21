class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|
      t.integer :user_id
      t.string :name
      t.string :title
      t.string :work_number
      t.string :mobile_number
      t.string :fax_number
      t.string :home_number

      t.timestamps
      
      t.belongs_to :user
    end
  end

  def self.down
    drop_table :profiles
  end
end
