json.annotations @annotations do |comment|
  if comment.json != 'null'
    json.(comment, :json)
  end
end


