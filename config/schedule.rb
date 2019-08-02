# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

# set :output, "#{path}/log/cron.log"
# job_type :script, "'#{path}/script/:task' :output" create job type

# every 15.minutes do
#   command "rm '#{path}/tmp/cache/foo.txt'"
#   # script "generate_report" this would run the generate_report file in script/generate_report
# end
#
#
# every :sunday, at: '4:30 AM' do
#   runner "Book.prune_books"
# end
#
# every :reboot do
#   rake "my:rake:task"
# end

# every 1.minute do
#   command "echo 'Mark, God will send a miracle'"
# end

# run "whenever --update-crontab"
# "crontab -l" to check jobs

