class CreateDles < ActiveRecord::Migration
  def self.up
    create_table :dles do |t|
      t.string :host
      t.string :disk
      t.references :amanda_config

      t.timestamps
    end
  end

  def self.down
    drop_table :dles
  end
end
