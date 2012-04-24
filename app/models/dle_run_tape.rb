class DleRunTape < ActiveRecord::Base
  belongs_to :dle_run
  belongs_to :tape
  has_one :overwritten_by_run, :class_name => :run
end
