# PERSONAL TEACHING - BACKEND USING RUBY ON RAILS
 > This project implements a simple API for an Appointments Book System using Ruby on Rails, as part of my final project at Microverse.


## Data Model
![screenshot-data-model](https://user-images.githubusercontent.com/36812672/102723950-ead38800-42d9-11eb-95fb-3fe6cfd31146.png)


## Built With
- Ruby on Rails
- PostgreSQL as database
- Doorkeeper for Sign In tokens
- Rubocop as linter
- Rspec for testing
- Apipie for API documentation
- Cloudinary for image storage


## Features
- Sign In with tokens managed by Doorkeeper.
- Model and controller for Users.
- Model and controller for Teachers.
- Model and controller for Appointments.
- Documentation using Apipie for Rails.


## Live Demo
[Personal Teaching API](https://floating-anchorage-41841.herokuapp.com/)


## How to Install
- Install Ruby in your system. To install Ruby, you can read the [Documentation](https://www.ruby-lang.org/en/documentation/installation/).
- Install Rails. You can read this [page](https://www.theodinproject.com/courses/ruby-on-rails/lessons/your-first-rails-application-ruby-on-rails).
- Clone it using **git clone** command.
- Run in your terminal **bundle install**.
- Run in your terminal **rails db:create**.
- Run in your terminal **rails db:migrate**.
- Run in your terminal **rails db:seed**.
- Create an account (it is for free) in [Cloudinary](https://cloudinary.com/users/login), confirm your e-mail and sign in.
- Go to [Cloudinary Account Settings](https://cloudinary.com/console/settings/account) and change the default name of your cloud (try to use a very long random string, more than 30 characters).
- Copy your **cloud_name** in ```config/application.rb``` (replacing the value in **config.x.cloudinary.cloud_name**)
- Go to your [Cloudinary Upload Settings](https://cloudinary.com/console/settings/upload).
- Move to **Upload presets** and create new strong **Unsigned preset**. Try to use a long string (more than 60 characters).
- Copy your **upload_preset** in ```config/application.rb``` (replacing the value in **config.x.cloudinary.upload_preset**)
- Run in your terminal **rails server**.


## Automated Test
- This project uses RSpec for unit and integration testing.
- All files are in **spec** directory.
- In order to run the tests, in terminal, type: ```rspec```


## API Documentation
- This project uses RSpec for unit and integration testing.
- All files are in **spec** directory.
- In order to run the tests, in terminal, type: ```rspec```


## Author
👤 **Sergio Zambrano**
- Github: [@sergiomauz](https://github.com/sergiomauz)
- Twitter: [@sergiomauz](https://twitter.com/sergiomauz)
- Linkedin: [Sergio Zambrano](https://www.linkedin.com/in/sergiomauz/)


## 🤝 Contributing
Contributions, issues and feature requests are welcome!. Feel free to check the [issues page](../../issues/).


## Show your support
Give a ⭐️ if you like this project!


## Credits
- Read the requirements and tips for backend at Notion [Book an Appointment](https://www.notion.so/Final-Capstone-Project-Book-an-Appointment-41ded2ee99ff4fe4becf91acb332ca26).


## 📝 License
This project is [MIT](./LICENSE) licensed.