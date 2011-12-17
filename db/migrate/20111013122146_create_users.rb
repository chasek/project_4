class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :username
      t.string :email
      t.boolean :admin, :default => false
      t.boolean :active, :default => true
      t.string :encrypted_password
      t.string :salt

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
