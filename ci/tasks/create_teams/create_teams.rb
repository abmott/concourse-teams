#!/usr/bin/env ruby
require 'json'
wrkdir = Dir.pwd
##{ENV['PCF_ENVIRONMENT']}
file = File.read("#{wrkdir}/config.json")
teams = JSON.parse(file)
#create Cert File
File.write("#{wrkdir}/wildcard.cer", "#{ENV['WILDCARD_CERT']}")
#connect to concourse environment
puts "logging onto #{ENV['CONCOURSE_ENV']}"
fly = `fly login -t #{ENV['CONCOURSE_ENV']} -c #{ENV['CONCOURSE_URL']} -u #{ENV['CONCOURSE_ADMIN']} -p "#{ENV['CONCOURSE_PASS']}" -k`
puts "syncing fly cli"
flysync = `fly -t #{ENV['CONCOURSE_ENV']} sync`
#create team from config.json
teams.keys.each do |team|
  unless teams["#{team}"]["#{ENV['CONCOURSE_ENV']}_space_guid"] == "not set"
    puts "Started creating concourse team #{team}"
    fly = `fly -t #{ENV['CONCOURSE_ENV']} set-team -n #{team} --non-interactive --uaa-auth-client-id #{ENV['CLIENT_ID']} --uaa-auth-client-secret '#{ENV['CLIENT_SECRET']}' --uaa-auth-auth-url #{ENV['AUTH_URL']} --uaa-auth-token-url #{ENV['TOKEN_URL']} --uaa-auth-cf-url #{ENV['CF_URL']} --uaa-auth-cf-ca-cert #{ENV['CF_CA_CERT']} --uaa-auth-cf-space #{teams["#{team}"]["#{ENV['CONCOURSE_ENV']}_space_guid"]}`
    puts "Finished creating concourse team #{team}"
  end
end
#remove cert from system
File.delete("#{wrkdir}/wildcard.cer") if File.exist?("#{wrkdir}/wildcard.cer")
