class CreateRuns < ActiveRecord::Migration
  def self.up
    create_table :runs do |t|
      t.datetime :date
      t.references :amanda_config

      t.timestamps
    end
  end

  def self.down
    drop_table :runs
  end
end
