json.array!(@users) do |user|
  json.id user.id
  json.fullname user.fullname
  json.username user.username
  json.email user.email
  json.admin user.admin
end
