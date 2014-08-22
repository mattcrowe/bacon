class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.references :client, index: true
      t.references :user, index: true
      t.decimal :total, :precision => 10, :scale => 2
      t.decimal :paid, :precision => 10, :scale => 2
      t.date :starts_at
      t.date :ends_at
      t.date :paid_at
      t.timestamps
    end
  end
end
