json.extract! teacher, :id, :fullname, :email, :photo, :course, :description, :created_at, :updated_at
json.url teacher_url(teacher, format: :json)
