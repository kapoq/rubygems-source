module ResponseHelpers
  def last_body
    last_response.body
  end
end

World(ResponseHelpers)
