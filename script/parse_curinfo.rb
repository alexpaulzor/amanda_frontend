

#USAGE: $0 <config>
#

#AMANDA_ROOT = "/etc/amanda"
AMANDA_ROOT = "/tmp"

config_name = ARGV[0]

if not config_name or config_name.length == 0
  abort "Must specify config name"
end

config = AmandaConfig.find_or_create_by_name(config_name)

curinfo_root = "#{AMANDA_ROOT}/#{config.name}/curinfo"

new_runs = []

Dir.foreach(curinfo_root) do |host|
  next if host.start_with?('.')
  puts "Processing host #{host}"
  Dir.foreach("#{curinfo_root}/#{host}") do |disk|
    next if disk.start_with?('.')
    puts "Processing disk #{host}/#{disk}"
    dle = Dle.find_or_create_by_host_and_disk_and_amanda_config_id(host, disk, config.id)

    info_filename = "#{curinfo_root}/#{host}/#{disk}/info"

    File.foreach(info_filename) do |line|
      if line.start_with?("history:")
        fields = line.split
        run = Run.find_or_create_by_amanda_config_id_and_date(config.id, Time.at(fields[4].to_i))
        dle_run = DleRun.find_or_initialize_by_run_id_and_dle_id(run.id, dle.id)
        if not dle_run.persisted?
          if not new_runs.include?(run)
            puts "New run: #{run}"
            new_runs << run
          end
          puts "New dle run: #{dle} @ #{run}"
          dle_run.level = fields[1].to_i
          dle_run.size = fields[3].to_i
          dle_run.save
        end
      end
    end
  end
end

Dir.glob("#{AMANDA_ROOT}/#{config.name}/log.*") do |log_filename|
  puts "Reading log #{log_filename}"
  next if not File.exist?(log_filename)
  File.foreach(log_filename) do |line|
    if line.start_with?("PART taper")
      puts "Got line #{line}"
      fields = line.split
      tape_name = fields[2]
      host = fields[4]
      disk = fields[5]
      date = fields[6]
      size = fields[12]

      timestamp = Time.mktime(date[0,4], date[4,2], date[6,2], date[8,2], date[10,2], date[12,2])
      run = Run.find_by_amanda_config_id_and_date(config.id, timestamp)
      puts "Got run #{run}"
      next if not run
      next if not new_runs.include?(run)

      dle = Dle.find_by_amanda_config_id_and_host_and_disk(config.id, host, disk)
      puts "Got dle #{dle}"
      next if not dle

      dle_run = DleRun.find_by_run_id_and_dle_id(run.id, dle.id)
      puts "Got dle_run #{dle_run}"
      next if not dle_run

      tape = Tape.find_or_create_by_name_and_amanda_config_id(tape_name, config.id)
      puts "Got tape #{tape}"

      # invalidate old tapes
      #old_dle_run_tapes = DleRunTape.find_all_by_tape_id_and_overwritten_by_run_id(tape.id, nil)
      #old_dle_run_tapes.each do |dle_run_tape|
      #  if dle_run_tape.dle_run.run_id != run.id
      #    puts "Invalidating dle run tape #{dle_run_tape}"
      #    dle_run_tape.overwritten_by_run_id = run.id
      #    dle_run_tape.save!
      #  end
      #end
    
      dle_run_tape = DleRunTape.find_or_initialize_by_tape_id_and_dle_run_id(tape.id, dle_run.id)
      if dle_run_tape.persisted?
        dle_run_tape.size += size.to_i
      else
        dle_run_tape.size = size.to_i
      end
      dle_run_tape.save
    end
  end
end


