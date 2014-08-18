class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name
      t.string :contact
      t.string :email
      t.decimal :rate
      t.timestamps
    end
  end
end
