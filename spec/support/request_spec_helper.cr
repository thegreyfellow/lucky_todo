require "http/client"

class RequestSpecHelper
  CSRF_TOKEN = "statictesttoken"

  getter! response
  @response : HTTP::Client::Response? = nil

  # def visit(path : String, headers : HTTP::Headers? = nil)
  #   request = HTTP::Request.new("GET", path, headers)
  #   @response = process_request(request)
  # end

  def get(path : String, headers : HTTP::Headers? = nil)
    request = HTTP::Request.new("GET", path, headers)
    @response = process_request(request)
  end

  def post(path : String, body : Hash(String, String), headers : HTTP::Headers? = nil)
    request_with_body("POST", path, with_csrf_token(body))
  end

  def put(path : String, body : Hash(String, String), headers : HTTP::Headers? = nil)
    request_with_body("PUT", path, with_csrf_token(body))
  end

  # FIXME: PATCH is not yet handeled by lucky.
  # def patch(path : String, body : Hash(String, String), headers : HTTP::Headers? = nil)
  #   request_with_body("PATCH", path, with_csrf_token(body))
  # end

  def delete(path : String, headers : HTTP::Headers? = nil)
    request_with_body("DELETE", path, with_csrf_token(body))
  end

  private def with_csrf_token(body : Hash(String, String))
    body[Lucky::ProtectFromForgery::PARAM_KEY] = CSRF_TOKEN
    body
  end

  private def request_with_body(method : String, path : String, body : Hash(String, String))
    body_strings = [] of String
    body.each do |key, value|
      body_strings << "#{URI.escape(key)}=#{URI.escape(value)}"
    end
    request = HTTP::Request.new(method, path, nil, body_strings.join("&"))
    @response = process_request(request)
  end

  private def process_request(request)
    io = IO::Memory.new
    response = HTTP::Server::Response.new(io)
    context = HTTP::Server::Context.new(request, response)
    context.session[Lucky::ProtectFromForgery::SESSION_KEY] = CSRF_TOKEN
    middlewares.call context
    response.close
    io.rewind
    HTTP::Client::Response.from_io(io, decompress: false)
  end

  def middlewares
    HTTP::Server.build_middleware([
      Lucky::HttpMethodOverrideHandler.new,
      Lucky::SessionHandler.new,
      Lucky::ErrorHandler.new(action: Errors::Show),
      Lucky::RouteHandler.new
    ])
  end

  def includes?(expected_value)
    response.body.includes? expected_value
  end
end
