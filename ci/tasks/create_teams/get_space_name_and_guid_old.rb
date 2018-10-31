#!/usr/bin/env ruby
require 'json'
require 'yaml'
require_relative 'get_space_info'

def get_space_name_and_guid(spaces)
  spaces_and_guid = Hash.new
  space_info = get_space_info(spaces)
  space_info['resources'].each do |space_array|
    space_array.each do |k, v|
      if k == "entity"
        if !v['name'].include?("dev2") || !v['name'].include?("cccm")
          if v['name'].include?("dev") || v['name'].include?("DEV")
            spaces_and_guid.merge!("#{v['name']}": "#{v['apps_url']}".split("/v2/spaces/")[1].split("/apps")[0])
          end
        end
      end
    end
  end
  return spaces_and_guid
end
