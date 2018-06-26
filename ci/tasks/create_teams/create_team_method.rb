#!/usr/bin/env ruby

def create_team(space, guid, c_env, client_id, client_secret, auth_url, token_url, cf_url)
  wrkdir = Dir.pwd
  puts "Started creating concourse team #{space}"
  puts "#{c_env} #{space}"
  fly = `fly -t #{c_env} set-team -n #{space} \
  --non-interactive \
  --uaa-auth-client-id #{client_id} \
  --uaa-auth-client-secret '#{client_secret}' \
  --uaa-auth-auth-url #{auth_url} \
  --uaa-auth-token-url #{token_url} \
  --uaa-auth-cf-url #{cf_url} \
  --uaa-auth-cf-ca-cert #{wrkdir}/wildcard.cer \
  --uaa-auth-cf-space #{guid}`
  puts "Finished creating concourse team #{space}"
end
