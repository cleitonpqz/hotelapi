# Require the bundler gem and then call Bundler.require to load in all gems
# listed in Gemfile.
require 'bundler'
Bundler.require

# Setup DataMapper with a database URL. On Heroku, ENV['DATABASE_URL'] will be
# set, when working locally this line will fall back to using SQLite in the
# current directory.
DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite://#{Dir.pwd}/development.sqlite")

# Define a simple DataMapper model.
class Hotel
  include DataMapper::Resource

  ACCOMMODATION_TYPES = ['Hotel', 'Hostel', 'Motel', 'Cottage', 'Chalet']

  property :id, Serial, :key => true
  property :created_at, DateTime
  property :name, String, :length => 255, :required => true, :unique => true
  property :address, String, :length => 255, :required => true
  property :star_rating, Integer
  property :accommodation_type, String, :length => 255, :required => true

  validates_within :star_rating, :set => 1..5
  validates_within :accommodation_type, :set => ACCOMMODATION_TYPES
end

# Finalize the DataMapper models.
DataMapper.finalize

# Tell DataMapper to update the database according to the definitions above.
DataMapper.auto_upgrade!

helpers do
  def json_status(code, reason)
    status code
    {
      :status => code,
      :reason => reason
    }.to_json
  end

  def accept_params(params, *fields)
    h = { }
    fields.each do |name|
      h[name] = params[name] if params[name]
    end
    h
  end
end

get '/' do
  send_file './public/index.html'
end

# Route to show all Hotels, ordered like a blog
get '/hotels' do
  content_type :json
  if @hotels = Hotel.all(:order => :created_at.desc)
    @hotels.to_json
  else
    json_status 404, 'Not found'
  end
end

get '/hotels/search' do
  content_type :json
  unless params[:q]
        json_status 400, "Missing search parameter"
  else
    if @hotels = Hotel.all(:name.like => "%#{params[:q]}%") | Hotel.all(:address.like => "%#{params[:q]}%")
      @hotels.to_json
    else
      json_status 404, 'Not found'
    end
  end
end

# CREATE: Route to create a new Hotel
post '/hotels' do
  content_type :json

  new_params = accept_params(params, :name, :star_rating, :address, :accommodation_type)
  @hotel = Hotel.new(new_params)

  if @hotel.save
    headers["Location"] = "/hotels/#{@hotel.id}"
    status 201
    @hotel.to_json
  else
    json_status 400, @hotel.errors.to_hash
  end
end

# READ: Route to show a specific Hotel based on its `id`
get '/hotels/:id' do
  content_type :json
  @hotel = Hotel.get(params[:id].to_i)

  if @hotel
    @hotel.to_json
  else
    json_status 404, 'Not found'
  end
end

# UPDATE: Route to update a Hotel
put '/hotels/:id/?' do
  content_type :json
  new_params = accept_params(params, :name, :star_rating, :address, :accommodation_type)
  if @hotel = Hotel.get(params[:id].to_i)
    @hotel.attributes = @hotel.attributes.merge(new_params)

    if @hotel.save
      @hotel.to_json
    else
      json_status 400, @hotel.errors.to_hash
    end
  else
    json_status 404, 'Not found'
  end
end

# DELETE: Route to delete a Hotel
delete '/hotels/:id/?' do
  content_type :json
  if @hotel = Hotel.get(params[:id].to_i)
    @hotel.destroy!
    status 204
  else
    json_status 404, "Not found"
  end
end


