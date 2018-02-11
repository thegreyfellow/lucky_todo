class Errors::Show < Lucky::ErrorAction
  def handle_error(error : JSON::ParseException)
    message = "There was a problem parsing the JSON." \
              " Please check that it is formed correctly"
    json Errors::ShowSerializer.new(message), status: 400
  end

  def handle_error(error : LuckyRecord::RecordNotFoundError)
    message = error.message.to_s
    json Errors::ShowSerializer.new(message), status: 404
  end

  def handle_error(error : Exception)
    error.inspect_with_backtrace(STDERR)
    message = "An unexpected error occurred"
    json Errors::ShowSerializer.new(message), status: 500
  end

  private def render_error_page(status : Int32, title : String = "We're sorry. Something went wrong.")
    render Errors::ShowPage, status: status, title: title
  end
end
