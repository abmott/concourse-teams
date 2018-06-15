#!/usr/bin/env ruby
require 'json'
require 'yaml'

def parse_space_guid(url)
  guid = "#{url.split("/v2/organizations/")[1].split("/spaces")[0]}"
  return guid
end
