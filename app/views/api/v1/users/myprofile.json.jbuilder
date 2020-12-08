json.myprofile do
  json.id current_user.id
  json.fullname current_user.fullname
  json.username current_user.username
  json.email current_user.email
  json.admin current_user.admin
end
