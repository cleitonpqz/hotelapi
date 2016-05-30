# Hotel API

## How to install and execute this code

1. Clone this repository

2. Install Ruby on your computer

3. Open terminal and navigate to folder where have cloned this repository, like so:

        $ cd path/to/this/repository/cloned

4. Excute following commandos to Install the gems:

        $ gem install bundler
        $ bundle install --without production

5. Execute following commands to run the app:

        $ bundle exec rackup

This command creates a server on your computer running at
`http://localhost:9292`.

Type that in to a web browser on your computer and you should see the contents of `views/index.erb`.

6. Whenever you change code in `app.rb` you'll need to restart the server.

Press "Ctrl + C" in terminal to stop the server and then repeat step 5.
