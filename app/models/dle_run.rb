class DleRun < ActiveRecord::Base
  belongs_to :run
  belongs_to :dle
  has_many :dle_run_tapes

  def to_s
    "#{self.dle} @ #{self.run}"
  end

  def size_human
    if self.size > 1024 * 1024 * 1024
      sprintf("%.2f TB", size.to_f / (1024 * 1024 * 1024))
    elsif self.size > 1024 * 1024
      sprintf("%.2f GB", size.to_f / (1024 * 1024))
    elsif self.size > 1024
      sprintf("%.2f MB", size.to_f / (1024))
    else
      "#{size} KB"
    end
  end
end
