#!/usr/bin/env ruby

def connect_to_concourse(c_env, c_user, c_pass, c_url)
  puts "logging onto #{c_env}"
  fly = `fly login \
  -t #{c_env} \
  -c #{c_url} \
  -u #{c_user} \
  -p "#{c_pass}" \
  -k`
  puts "syncing fly cli"
  flysync = `fly -t #{c_env} sync`
end
