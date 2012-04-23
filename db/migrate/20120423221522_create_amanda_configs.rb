class CreateAmandaConfigs < ActiveRecord::Migration
  def self.up
    create_table :amanda_configs do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :amanda_configs
  end
end
