module RequestSpecHelper
  def json
    JSON.parse(response.body)
  end

  def valid_headers
    {
      # Προσθήκη :: πριν από το JsonWebToken
      "Authorization" => ::JsonWebToken.encode(user_id: user.id),
      "Content-Type" => "application/json"
    }
  end

  def invalid_headers
    {
      "Authorization" => nil,
      "Content-Type" => "application/json"
    }
  end
end