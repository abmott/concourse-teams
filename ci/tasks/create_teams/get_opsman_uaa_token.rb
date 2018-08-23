#!/usr/bin/env ruby
require 'json'
require 'yaml'
def get_opsman_uaa_token(pcf_opsman_url, opsman_admin, opsman_pass)
  target = `uaac target #{pcf_opsman_url}/uaa --skip-ssl-validation`
  connect = `uaac token owner get opsman #{opsman_admin} -p "#{opsman_pass}" -s ""`
  context = `uaac context`
  token = context.split("access_token: ")[1].split("      token_type: bearer")[0]
  return token
end
