require 'net/http'

# Examples: https://gist.github.com/natritmeyer/6241076

class HttpClient
  def initialize(base_url, username = nil, password = nil, use_ssl = false)
    @base_url = base_url
    @username = username
    @password = password
    @use_ssl  = use_ssl
  end

  def get(path, headers = {})
    uri = URI.parse("#{@base_url}#{path}")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true if @use_ssl
    request = Net::HTTP::Get.new(uri.request_uri)
    request.basic_auth @username, @password unless @username.nil?
    headers.keys.each do |key|
      request[key] = headers[key]
    end
    response = http.request(request)
    handle_response(response)
  end

  def post(path, headers = {}, body = "")
    uri = URI.parse("#{@base_url}#{path}")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true if @use_ssl
    request = Net::HTTP::Post.new(uri.request_uri)
    request.basic_auth @username, @password unless @username.nil?
    headers.keys.each do |key|
      request[key] = headers[key]
    end
    request.body = body
    response = http.request(request)
    handle_response(response)
  end

  def put(path, headers = {}, body = "")
    uri = URI.parse("#{@base_url}#{path}")
    puts uri
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true if @use_ssl
    request = Net::HTTP::Put.new(uri.request_uri)
    request.basic_auth @username, @password unless @username.nil?
    headers.keys.each do |key|
      request[key] = headers[key]
    end
    request.body = body
    response = http.request(request)
    handle_response(response)
  end
  
  def delete(path)
    uri = URI.parse("#{@base_url}#{path}")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true if @use_ssl
    request = Net::HTTP::Delete.new(uri.request_uri)
    request.basic_auth @username, @password unless @username.nil?
    response = http.request(request)
    handle_response(response)
  end

  def handle_response(response)
    if response.code === "200"
      return response.body
    else
      puts response.code
      puts response.body
    end
  end
end