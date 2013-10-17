class Faraday::Response
  def data
    body["data"] if body
  end
end