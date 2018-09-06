#!/usr/bin/env ruby

def create_team(space, guid, c_env, client_id, client_secret, auth_url, token_url, cf_url)
  wrkdir = Dir.pwd
  puts "Started creating concourse team #{space}"
  fly = `fly -t #{c_env} set-team -n "#{space}" \
  --cf-space #{org}:#{space}
  puts "Finished creating concourse team #{space}"
  puts "--------------------------------------------------"
end
