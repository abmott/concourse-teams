#!/usr/bin/env ruby
require 'json'
require 'yaml'
require_relative 'get_opsman_uaa_token'
require 'optparse' #used to parse command-line arrguments

wrkdir = Dir.pwd
options = {:environment => nil}
parser = OptionParser. new do|opts|
  opts.banner = "Usage get_director_manifest.rb [options]"
  opts.on('-e', '--environment environment', 'Username Example: pdc or gdc or tent') do |environment|
    options[:environment] = environment.downcase
  end
end

parser.parse!

if options[:environment] == nil
  puts ""
  print green("Enter Target Envionment (pdc, gdc, or tent): -> ")
    options[:environment] = STDIN.gets.chomp
end

var_file = File.read("#{wrkdir}/params-local.json")
vars_values = JSON.parse(var_file)
vars_values.keys.each do |env|
  if env == "#{options[:environment]}"
    opsman_admin = vars_values["#{env}"]['opsman_admin']
    opsman_pass = vars_values["#{env}"]['opsman_pass']
    pcf_opsman_url = vars_values["#{env}"]['pcf_opsman_url']

    access_token = get_opsman_uaa_token(pcf_opsman_url, opsman_admin, opsman_pass)

    manifest = `curl "#{pcf_opsman_url}/api/v0/deployed/director/manifest" -X GET -H "Authorization: Bearer #{access_token}"`
    puts manifest
  end
end
