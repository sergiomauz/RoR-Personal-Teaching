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
[Personal Teaching API](https://ror-personal-teaching-backend.herokuapp.com/api/v1/). See the documentation before to use.


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
- Copy your **cloud_name** in ```config/application.rb``` (replace the value in **config.x.cloudinary.cloud_name**)
- Go to your [Cloudinary Upload Settings](https://cloudinary.com/console/settings/upload).
- Move to **Upload presets** and create new strong **Unsigned preset**. Try to use a long string (more than 60 characters).
- Copy your **upload_preset** in ```config/application.rb``` (replace the value in **config.x.cloudinary.upload_preset**)
- Run in your terminal ```rails s```.


## Automated Test
- This project uses RSpec for unit and integration testing.
- All files are in **spec** directory.
- In order to run the tests, in terminal, type: ```rspec```, it should return 71 examples and 0 failures.


## API Documentation
- This project uses **Apipie Gem** for API documentation.
- After run ```rails s```, go to **http://localhost:3000/api/v1/apipiedoc** in your favorite browser to see the API documentation.
- Also, you can go to **https://ror-personal-teaching-backend.herokuapp.com/api/v1/apipiedoc** for online documentation, but you will need to sign in as an admin user (see the **db/seeds.rb** file to know the admin user example).
- This API uses [Doorkeeper](https://github.com/doorkeeper-gem/doorkeeper#documentation) to Sign In with JWT. 
- To sign in and use the API (at least if it is required), you must create an **access_token** using ```/api/v1/oauth/token``` sending a POST request:

```json
{
  "grant_type": "password",
  "username": "anyuser",
  "password": "som3StrongPassw0rd"
}
```

- API will return something like this:

```json
{
    "access_token": "7p-ol7DSFL8pyFx_a1McTQQq9fIWEgYTSCSCg8DQEhw",
    "token_type": "Bearer",
    "expires_in": 3600,
    "refresh_token": "kcu0UysdF-bZcOi_xYcAvSkIfvejggcW_O3AGgdYPug",
    "created_at": 1609000354
}
```

- You must use **access_token** as **Authorization** parameter (prefixed by the word **Bearer**) in the Header of every request to API (if it is required, according to API documentation).
- Also, you can use **refresh_token** to renew your **access_token** without passing username and password again. For that, you must send a POST request:

```json
{
  "grant_type": "refresh_token",
  "refresh_token": "kcu0UysdF-bZcOi_xYcAvSkIfvejggcW_O3AGgdYPug"
}
```

- API will return something similar when you pass username and password:

```json
{
    "access_token": "HA2P1ZKKJZJ4SajKrjSTX9R4DydNlXQhi5QyFVTuF08",
    "token_type": "Bearer",
    "expires_in": 3600,
    "refresh_token": "s6eBdXEb0mnc4AzVgVzAgyC-owhmww4LNP2dIn3Dk9Q",
    "created_at": 1609003229
}
```


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