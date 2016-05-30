# Hotel API

## How to install and execute this code

1. Clone this repository

2. Install Ruby on your computer

3. Open terminal and navigate to folder where have cloned this repository, like so:

        $ cd path/to/this/repository/cloned

4. Excute following commands to Install the gems:

        $ gem install bundler
        $ bundle install --without production

5. Execute following commands to run the app:

        $ bundle exec rackup

This command creates a server on your computer running at
`http://localhost:9292`.

Type that in to a web browser on your computer and you should see the contents of `views/index.erb`.

6. Whenever you change code in `app.rb` you'll need to restart the server.

Press "Ctrl + C" in terminal to stop the server and then repeat step 5.

## Links for this API running on Heroku [Demo](https://dry-waters-79640.herokuapp.com/)

- GET 'https://dry-waters-79640.herokuapp.com/hotels' for get a list of all hotels.
- GET 'https://dry-waters-79640.herokuapp.com/hotels/:id' for get and specific hotel.
- GET 'https://dry-waters-79640.herokuapp.com/hotels/search' for search by name or address (passing 'q' param)
- POST 'https://dry-waters-79640.herokuapp.com/hotels' for create a new hotel.
- PUT 'https://dry-waters-79640.herokuapp.com/hotels/:id' for update a specific hotel.
- DELETE 'https://dry-waters-79640.herokuapp.com/hotels/:id' for delte a specific hotel.

Hotel Params:
- **name**
- **address**
- **star_rating** (must be between 1 and 5)
- **accommodation_type**, only accepts the following values:
    - Hotel
    - Hostel
    - Motel
    - Cottage
    - Chalet


