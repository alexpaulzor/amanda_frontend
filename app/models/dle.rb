class Dle < ActiveRecord::Base
  belongs_to :amanda_config
  has_many :dle_runs

  def to_s
    "#{self.amanda_config}:#{self.host}/#{self.disk}"
  end

  def last_run
    self.dle_runs.sort_by {|dr| dr.run.date}.last
  end

  def last_lev0
    self.dle_runs.where(:level => 0).sort_by {|dr| dr.run.date}.last
  end

  def name
    "#{self.host}/#{self.disk}"
  end
end
