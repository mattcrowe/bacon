class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.references :client, index: true
      t.datetime :paid_at
      t.timestamps
    end
  end
end
