class DleRunTape < ActiveRecord::Base
  belongs_to :dle_run
  belongs_to :tape
end
