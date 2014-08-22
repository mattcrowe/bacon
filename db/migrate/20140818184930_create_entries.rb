class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.references :task, index: true
      t.references :invoice, index: true
      t.decimal :qty
      t.decimal :rate
      t.date :done_at
      t.timestamps
    end
  end
end
