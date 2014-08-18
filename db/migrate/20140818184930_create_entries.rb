class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.references :task, index: true
      t.decimal :hours
      t.decimal :rate
      t.datetime :done_at
      t.timestamps
    end
  end
end
