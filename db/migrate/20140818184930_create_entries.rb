class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.references :task, index: true
      t.references :invoice, index: true
      t.decimal :qty, :precision => 5, :scale => 2
      t.decimal :rate, :precision => 10, :scale => 2
      t.date :done_at
      t.timestamps
    end
  end
end
