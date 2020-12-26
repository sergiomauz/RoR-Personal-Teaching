# rubocop: disable Metrics/ModuleLength
module TeachersDoc
  extend Apipie::DSL::Concern

  # GET /teachers
  api :GET, '/teachers', 'List teachers'
  header :Authorization, 'Token generated by <strong>oauth_token</strong> prefixed by the word <strong>Bearer</strong>.
                          <br><strong>Example:</strong> Bearer dfoiaudsfasdfasd34p534spauasfd', required: true
  returns code: 200, desc: 'A successful response' do
    property :teachers, Array, desc: 'Array of teacher objects.' do
      property :teacher, Hash, desc: 'Teachers object.' do
        property :id, Integer, desc: 'Teacher ID.'
        property :fullname, String, desc: 'Teacher fullname.'
        property :email, String, desc: 'Teacher email.'
        property :photo, String, desc: 'URL for a photo or avatar of the teacher.'
        property :course, String, desc: 'Course to learn.'
        property :description, String, desc: 'Description and details of the course.'
      end
    end
  end
  error code: 401, desc: 'Header "Authorization" is missed.'
  error code: 403, desc: 'Header "Authorization" is not valid or expired.'
  def index
    # Something
  end

  # GET /teachers/1
  api :GET, '/teachers/:id', 'Show a teacher'
  param :id, Integer, desc: 'Teacher ID to show.', required: true
  header :Authorization, 'Token generated by <strong>oauth_token</strong> prefixed by the word <strong>Bearer</strong>.
                          <br><strong>Example:</strong> Bearer dfoiaudsfasdfasd34p534spauasfd', required: true
  returns code: 200, desc: 'A successful response' do
    property :teacher, Hash, desc: 'Teachers object.' do
      property :id, Integer, desc: 'Teacher ID.'
      property :fullname, String, desc: 'Teacher fullname.'
      property :email, String, desc: 'Teacher email.'
      property :photo, String, desc: 'URL for a photo or avatar of the teacher.'
      property :course, String, desc: 'Course to learn.'
      property :description, String, desc: 'Description and details of the course.'
    end
  end
  error code: 401, desc: 'Header "Authorization" is missed.'
  error code: 403, desc: 'Header "Authorization" is not valid or expired.'
  def show
    # Something
  end

  # GET /teachers/last
  api :GET, '/teachers/last', 'Show last registered teacher'
  header :Authorization, 'Token generated by <strong>oauth_token</strong> prefixed by the word <strong>Bearer</strong>.
                          <br><strong>Example:</strong> Bearer dfoiaudsfasdfasd34p534spauasfd', required: true
  returns code: 200, desc: 'A successful response' do
    property :teacher, Hash, desc: 'Teachers object.' do
      property :id, Integer, desc: 'Teacher ID.'
      property :fullname, String, desc: 'Teacher fullname.'
      property :email, String, desc: 'Teacher email.'
      property :photo, String, desc: 'URL for a photo or avatar of the teacher.'
      property :course, String, desc: 'Course to learn.'
      property :description, String, desc: 'Description and details of the course.'
    end
  end
  error code: 401, desc: 'Header "Authorization" is missed.'
  error code: 403, desc: 'Header "Authorization" is not valid or expired.'
  def last
    # Something
  end

  # GET /teachers/1/availability/2020-01-01
  api :GET, '/teachers/:id/availability/:date', 'Show the availability of a teacher on an exact date'
  header :Authorization, 'Token generated by <strong>oauth_token</strong> prefixed by the word <strong>Bearer</strong>.
                          <br><strong>Example:</strong> Bearer dfoiaudsfasdfasd34p534spauasfd', required: true
  param :id, Integer, desc: 'ID of the requested teacher.', required: true
  param :date, String, desc: 'Date to check availability, format: YYYY-MM-DD.', required: true
  returns code: 200, desc: 'A successful response' do
    property :teacher, Hash, desc: 'Teachers object.' do
      property :id, Integer, desc: 'Teacher ID.'
      property :availability, Array, desc: 'Array of integers, with hours of availability .'
    end
  end
  error code: 401, desc: 'Header "Authorization" is missed.'
  error code: 403, desc: 'Header "Authorization" is not valid or expired.'
  def availability
    # Something
  end

  # GET /teachers/1/appointments
  api :GET, '/teachers/:id/appointments', 'Show all the appointments of a teacher.'
  header :Authorization, 'Token generated by <strong>oauth_token</strong> prefixed by the word <strong>Bearer</strong>.
                          <br><strong>Example:</strong> Bearer dfoiaudsfasdfasd34p534spauasfd', required: true
  param :id, Integer, desc: 'Teacher ID to show.', required: true
  returns code: 200, desc: 'A successful response' do
    property :appointments, Array, desc: 'Array of appointment objects.' do
      property :appointment, Hash, desc: 'Appointment object.' do
        property :id, Integer, desc: 'Teacher ID.'
        property :scheduled_for, DateTime, desc: 'Date and Time for the appointment.'
        property :user_fullname, String, desc: 'User/Student fullname.'
        property :user_email, String, desc: 'User/Student email.'
        property :status, Integer, desc: '0: Past appointments<br>1: Incoming appointments.'
      end
    end
  end
  error code: 401, desc: 'Header "Authorization" is missed.'
  error code: 403, desc: 'Header "Authorization" is not valid or expired.'
  def appointments
    # Something
  end

  # POST /teachers
  api :POST, '/teachers', 'Create a teacher'
  header :Authorization, 'Token generated by <strong>oauth_token</strong> prefixed by the word <strong>Bearer</strong>.
                          <br><strong>Example:</strong> Bearer dfoiaudsfasdfasd34p534spauasfd', required: true
  param :teacher, Hash, required: true do
    param :fullname, String, desc: 'Teacher fullname.', required: true
    param :email, String, desc: 'Teacher email.', required: true
    param :photo, String, desc: 'URL for a photo or avatar of the teacher.', required: false
    param :course, String, desc: 'Course to learn.', required: true
    param :description, String, desc: 'Description and details of the course.', required: true
  end
  returns code: 200, desc: 'A successful response, returns destroyed teacher.' do
    property :teacher, Hash, desc: 'Teachers object.' do
      property :id, Integer, desc: 'Teacher ID.'
      property :fullname, String, desc: 'Teacher fullname.'
      property :email, String, desc: 'Teacher email.'
      property :photo, String, desc: 'URL for a photo or avatar of the teacher.'
      property :course, String, desc: 'Course to learn.'
      property :description, String, desc: 'Description and details of the course.'
    end
  end
  error code: 401, desc: 'Header "Authorization" is missed.'
  error code: 403, desc: 'Header "Authorization" is not valid or expired.'
  error :unprocessable_entity, 'Could not save the entity.'
  def create
    # Something
  end

  # PATCH/PUT /teachers/1
  api :PATCH, '/teachers/:id', 'Update a teacher'
  api :PUT, '/teachers/:id', 'Update a teacher'
  header :Authorization, 'Token generated by <strong>oauth_token</strong> prefixed by the word <strong>Bearer</strong>.
                          <br><strong>Example:</strong> Bearer dfoiaudsfasdfasd34p534spauasfd', required: true
  param :id, Integer, desc: 'ID of the requested teacher.', required: true
  param :teacher, Hash, required: true do
    param :fullname, String, desc: 'Teacher fullname.', required: false
    param :email, String, desc: 'Teacher email.', required: false
    param :photo, String, desc: 'URL for a photo or avatar of the teacher.', required: false
    param :course, String, desc: 'Course to learn.', required: false
    param :description, String, desc: 'Description and details of the course.', required: false
  end
  returns code: 200, desc: 'A successful response, returns destroyed teacher.' do
    property :teacher, Hash, desc: 'Teachers object.' do
      property :id, Integer, desc: 'Teacher ID.'
      property :fullname, String, desc: 'Teacher fullname.'
      property :email, String, desc: 'Teacher email.'
      property :photo, String, desc: 'URL for a photo or avatar of the teacher.'
      property :course, String, desc: 'Course to learn.'
      property :description, String, desc: 'Description and details of the course.'
    end
  end
  error code: 401, desc: 'Header "Authorization" is missed.'
  error code: 403, desc: 'Header "Authorization" is not valid or expired.'
  error :unprocessable_entity, 'Could not save the entity.'
  def update
    # Something
  end

  # DELETE /teachers/1
  api :DELETE, '/teachers/:id', 'Destroy a teacher'
  header :Authorization, 'Token generated by <strong>oauth_token</strong> prefixed by the word <strong>Bearer</strong>.
                          <br><strong>Example:</strong> Bearer dfoiaudsfasdfasd34p534spauasfd', required: true
  param :id, Integer, desc: 'ID of the requested teacher.', required: true
  returns code: 200, desc: 'A successful response, returns destroyed teacher.' do
    property :teacher, Hash, desc: 'Teachers object.' do
      property :id, Integer, desc: 'Teacher ID.'
      property :fullname, String, desc: 'Teacher fullname.'
      property :email, String, desc: 'Teacher email.'
      property :photo, String, desc: 'URL for a photo or avatar of the teacher.'
      property :course, String, desc: 'Course to learn.'
      property :description, String, desc: 'Description and details of the course.'
    end
  end
  error code: 401, desc: 'Header "Authorization" is missed.'
  error code: 403, desc: 'Header "Authorization" is not valid or expired.'
  def destroy
    # Something
  end
end
# rubocop: enable Metrics/ModuleLength