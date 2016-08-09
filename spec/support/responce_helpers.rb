module ResponseHelpers
  def json_response
    JSON.parse(response.body)
  end

  def serialized(obj, serializer=nil)
    serializer ||= "#{ obj.class.name }Serializer".constantize
    serializer.new(obj, root: 'resource').as_json.with_indifferent_access
  end
end
