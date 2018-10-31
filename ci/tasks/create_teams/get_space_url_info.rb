#!/usr/bin/env ruby
require 'json'
require 'yaml'

def get_space_url_info(organizations, org)
  org_info = get_org_info(organizations)
  org_info['resources'].each do |org_array|
    org_array.each do |k, v|
      if k == "entity"
        if v['name'] == org
          destination_url = "#{v['spaces_url']}"
          return destination_url
        end
      end
    end
  end
end
