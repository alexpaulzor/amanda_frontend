class Run < ActiveRecord::Base
  belongs_to :amanda_config
  has_many :dle_runs
  has_many :overwritten_dle_run_tapes, :class_name => :dle_run_tapes

  def to_s
    "#{self.amanda_config}:#{self.date}"
  end

  def pretty_date
    self.date.strftime("%Y-%m-%d %H:%M")
  end
end
