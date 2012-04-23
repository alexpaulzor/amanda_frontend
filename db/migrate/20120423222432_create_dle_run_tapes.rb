class CreateDleRunTapes < ActiveRecord::Migration
  def self.up
    create_table :dle_run_tapes do |t|
      t.references :dle_run
      t.references :tape
      t.integer :size
      t.boolean :overwritten

      t.timestamps
    end
  end

  def self.down
    drop_table :dle_run_tapes
  end
end
