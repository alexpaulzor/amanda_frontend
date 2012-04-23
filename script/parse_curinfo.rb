

#USAGE: $0 <config>
#

AMANDA_ROOT = "/etc/amanda"

config_name = ARGV[0]

if not config_name or config_name.length == 0
  abort "Must specify config name"
end

config = AmandaConfig.find_or_create_by_name(config_name)


curinfo_root = AMANDA_ROOT + "/" + config.name + "/curinfo"

host_dirs = Dir[curinfo_root]

new_runs = []

host_dirs.each do |host|
  disk_dirs = Dir[curinfo_root + "/" + host]
  disk_dirs.each do |disk|
    dle = Dle.find_or_create_by_host_and_disk_and_amanda_config(host, disk, config)

    File.foreach(curinfo_root + "/" + host + "/" + disk + "/info") do |line|
      if line.start_with?("history:")
        fields = line.split
        run = Run.find_or_create_by_amanda_config_and_date(config, Time.at(fields[4].to_i))
        dle_run = DleRun.find_or_initialize_by_run_and_dle(run, dle)
        if not dle_run.exists?
          dle_run.level = fields[1].to_i
          dle_run.size = fields[3].to_i
          dle_run.save
          if not new_runs.include?(run)
            new_runs << run
          end
        end
      end
    end
  end
end

new_runs.sort_by{|run| run.date}.each do |run|
  log_name = "log.#{run.date.to_s(:number)}.0"
  File.foreach(AMANDA_ROOT + "/" + config.name + "/" + log_name) do |line|
    if line.start_with?("PART taper")
      fields = line.split
      tape_name = fields[2]
      host = fields[4]
      disk = fields[5]
      size = fields[12]

      dle = Dle.find_by_amanda_config_and_host_and_disk(config, host, disk)

      dle_run = DleRun.find_by_run_and_dle(run, dle)

      tape = Tape.find_by_name_and_amanda_config(tape_name, config)

      # invalidate old tapes
      old_dle_run_tapes = DleRunTape.find_by_tape_and_overwritten_by_run_id(tape, nil)
      old_dle_run_tapes.each do |dle_run_tape|
        if dle_run_tape.dle_run.run_id != run.id
          dle_run_tape.overwritten_by_run_id = run.id
          dle_run_tape.save!
        end
      end
    
      dle_run_tape = dle_run.dle_run_tapes.find_or_initialize_by_tape(tape)
      if dle_run_tape.exists?
        dle_run_tape.size += size
      else
        dle_run_tape.size = size
      end
      dle_run_tape.save
    end
  end
end


