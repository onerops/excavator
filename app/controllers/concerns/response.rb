module Response
  def json_response(result, status = :ok)
    render json: result, status: status
  end
end