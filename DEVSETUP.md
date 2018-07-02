# Postgresql on Ubuntu
## Pre pg gem setup for Ubuntu Machines

### To install dependencies on Ubuntu try this:

$ sudo apt install libpq-dev

### Might have to install postgresql as well.

$ sudo apt install postgresql



# ActiveAdmin PostInstall TODOs
$ rails g active_admin:install

$ rails db:seed

# Must Restart Rails Server AFTER rails g active_admin:install and rails db:seed

if not you will see this error: 
# __uninitialized constant AdminUser__

# Frontend Setup
### use npx for newer versions of Node/Npm
$ npx create-react-app client
-or-
### use npm for older versions of Node/Npm
$ npm isntall -g create-react-app
$ create-react-app client

### once done, jump into client/src/index.js and remove these two lines:
import registerServiceWorker from ./registerServiceWorker';
regfsterServiceWorker();

### set proxy to api, in client/package.json
$ vim client/package.json

...
"name": "client",
"version": "0.1.0",
"private": true,
"proxy": "http://localhost:3001",
...

# Setup up Models
$ rails g model Drink title:string description:string steps:string source:string

# Heroku SETUP

1. create a package.json file in the root of your project.
```
{
  "name": "list-of-ingredients",
  "license": "MIT",
  "engines": {
    "node": "8.9.4",
    "yarn": "1.6.0"
  },
  "scripts": {
    "build": "yarn --cwd client install && yarn --cwd client build",
    "deploy": "cp -a client/build/. public/",
    "heroku-postbuild": "yarn build && yarn deploy"
  }
}
```

2. Add a Procfile to the root of project.
```
web: bundle exec rails s
release: bin/rake db:migrate
```

3. (Optional, if file is empty, or not created) Otherwise, create a config/secrets.yml file.
```
$ rails secret
```
```
development:
  secret_key_base: A_LONG_STRING_OF_LETTERS_AND_NUMBERS

test:
  secret_key_base: A_DIFFERENT_LONG_STRING_OF_LETTERS_AND_NUMBERS

production:
  secret_key_base: <%= ENV["SECRET_KEY_BASE"] %>
```

4. Using the "heroku cli" tool, create your app.
```
$ heroku apps:create
```

5. Now add your buildpacks in specific order, starting with Node.js so it starts first.
```
$ heroku buildpacks:add heroku/nodejs --index 1
$ heroku buildpacks:add heroku/ruby --index 2
```

6. Now you are ready to push your app to heroku.
```
$ git add .
$ git commit -vam "Initial commit"
$ git push heroku master
```

7. Great, now you can "seed" your database with this command:
```
$ heroku run rake db:seed
```

**If you receive this error after using the command above**
> Error R13 (Attach error) -> Failed to attach to process

**Then try this command instead**
```
$ heroku run:detached rake db:seed
```

8. Finally, run the following command to view you app on the web.
```
$ heroku open
```

