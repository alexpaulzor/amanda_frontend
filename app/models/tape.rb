class Tape < ActiveRecord::Base
  belongs_to :amanda_config
  has_many :dle_run_tapes

  def to_s
    "#{self.amanda_config}:#{self.name}"
  end

  def most_recent_run
    self.dle_run_tapes.joins(:run).order("runs.date ASC").first.run
  end
end
