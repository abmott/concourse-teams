#!/usr/bin/env ruby
require 'json'
require 'yaml'
require_relative 'get_space_info'

def get_space_name_and_guid(env_url, page_url, token)
  page = 1
  lastpage = 10
  #puts page_url
  page_url = page_url + "?order-direction=asc&results-per-page=100"
  #puts page_url
  spaces_and_guid = Hash.new
  until page > lastpage
    data = `curl "#{env_url}#{page_url}" -X GET -H "Authorization: bearer #{token}" -k -s`
    #puts "#{env_url}#{page_url}"
    space = JSON.parse(data)
    #puts space['total_pages']
    lastpage = space['total_pages']
    #puts space['next_url']
    page_url = space['next_url']
    page = page + 1
    #puts page
    space['resources'].each do |space_array|
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
  end
  #puts spaces_and_guid
  return spaces_and_guid
end
