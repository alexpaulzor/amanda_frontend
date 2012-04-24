class Tape < ActiveRecord::Base
  belongs_to :amanda_config
  has_many :dle_run_tapes
end
