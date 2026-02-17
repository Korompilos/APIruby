module RequestSpecHelper
  # Μετατρέπει το JSON response σε Ruby hash
  def json
    JSON.parse(response.body)
  end
end