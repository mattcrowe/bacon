class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.references :client, index: true
      t.decimal :total, :precision => 10, :scale => 2
      t.date :paid_at
      t.timestamps
    end
  end
end
