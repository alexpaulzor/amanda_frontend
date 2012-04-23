class CreateDleRuns < ActiveRecord::Migration
  def self.up
    create_table :dle_runs do |t|
      t.references :run
      t.references :dle
      t.integer :level
      t.integer :size

      t.timestamps
    end
  end

  def self.down
    drop_table :dle_runs
  end
end
