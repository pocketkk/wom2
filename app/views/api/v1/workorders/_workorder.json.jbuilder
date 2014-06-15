json.cache! workorder do
  json.customer workorder.customer
  json.address workorder.address
  json.phone workorder.phone

  json.user do
    json.device_token workorder.user.device_token
  end
end
