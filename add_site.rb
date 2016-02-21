# encoding: utf-8
# This script adds a user to the necessary Google Search Console.
# Example: ruby add_site.rb
require 'cgi'
require './tools/http_client.rb'

ACCESS_TOKEN = ""
API_KEY = ""
SITE = "http://example.com"
FOLDERS = ["/folder/","/folder-2/","/folder/subfolder/","/folder-2/subfolder/"]

def submit_site(folder)
  site_url = "#{SITE}#{folder}"

  @http_client = HttpClient.new("https://www.googleapis.com",'','',true)
  add_site = @http_client.put "/webmasters/v3/sites/#{CGI::escape(site_url)}" \
                              "/?key=#{API_KEY}", { 'Authorization' => "Bearer #{ACCESS_TOKEN}" }

  # Adding some delay to no run into load issues with the API
  sleep 0.25
end

FOLDERS.each { |folder| submit_site(folder) }