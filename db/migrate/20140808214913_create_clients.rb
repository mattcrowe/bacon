class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name
      t.decimal :rate, :precision => 10, :scale => 2
      t.string :contact, :limit => 50
      t.string :email
      t.string :address1
      t.string :address2
      t.string :city, :limit => 50
      t.string :state, :limit => 2
      t.string :zip, :limit => 10
      t.timestamps
    end
  end
end
