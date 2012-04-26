class DleRunTape < ActiveRecord::Base
  belongs_to :dle_run
  belongs_to :tape
  has_one :run, :through => :dle_run
  has_one :dle, :through => :dle_run
  has_one :overwritten_by_run, :class_name => "Run"

  def to_s
    "#{self.dle_run} on #{self.tape}"
  end

  def update_overwritten_by_run
    if not self.overwritten_by_run_id
      overwritten_by = DleRunTape.where(:tape_id => self.tape.id).joins(:run).where("runs.date > ?", self.run.date).order("runs.date ASC").first
      puts overwritten_by
      if overwritten_by
        self.overwritten_by_run_id = overwritten_by.id
        self.save!
      end
    end
  end
  
  def size_human
    if self.size > 1024 * 1024 * 1024 * 1024
      sprintf("%.2f TB", size.to_f / (1024 * 1024 * 1024 * 1024))
    elsif self.size > 1024 * 1024 * 1024
      sprintf("%.2f GB", size.to_f / (1024 * 1024 * 1024))
    elsif self.size > 1024 * 1024
      sprintf("%.2f MB", size.to_f / (1024 * 1024))
    elsif self.size > 1024
      sprintf("%.2f KB", size.to_f / (1024))
    else
      "#{size} B"
    end
  end
end
