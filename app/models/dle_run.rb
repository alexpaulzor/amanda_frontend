class DleRun < ActiveRecord::Base
  belongs_to :run
  belongs_to :dle
  has_many :dle_run_tapes
end
