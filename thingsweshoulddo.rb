class ThingsWeShouldDo < Sinatra::Base
  enable :sessions
  enable :method_override
  register Sinatra::Flash 
  ######################## CONFIG ######################
  set :title, 'Things We Should Do Before Leaving Oregon'
  set :google_analytics_id, ''
  ######################################################

  if ENV['MONGOHQ_URL']
    uri = URI.parse(ENV['MONGOHQ_URL'])
    MongoMapper.connection = Mongo::Connection.from_uri(ENV['MONGOHQ_URL'])
    MongoMapper.database = uri.path.gsub(/^\//, '')
  else
    MongoMapper.database = 'sobtvse'
  end

  helpers do
    def protected!
      session[:admin] = true if authorized?
      unless authorized?
        response['WWW-Authenticate'] = %(Basic realm="Restricted Area")
        throw(:halt, [401, "Not authorized\n"])
      end
    end

    def authorized?
      @auth ||=  Rack::Auth::Basic::Request.new(request.env)
      @auth.provided? && @auth.basic? && @auth.credentials && @auth.credentials == [ENV['admin_username'], ENV['admin_password']]
    end

    def is_admin?
      true if session[:admin] == true
    end
  end

  class Thing
    include MongoMapper::Document
    key :title, String, :required => true
    key :suggestion, Boolean, :default => true
    key :votes, Integer, :default => 0
    key :tags, String
    key :notes, String
    key :completed, Boolean, :default => false

    timestamps!
  end

  get '/' do 
    @things = Thing.where(suggestion:false).sort(:votes.desc)
    @count = Thing.where(suggestion:false, completed:false).count
    erb :index
  end

  get '/admin' do 
    protected!
    @no_header = true
    @thing = Thing.new
    @published = Thing.where(suggestion:false).sort(:updated_at.desc)
    @suggestions = Thing.where(suggestion:true).sort(:updated_at.desc)
    erb :admin
  end

  get '/new' do 
    protected!
    @no_header = true
    @thing = Thing.new
    erb :new
  end

  post '/new' do 
    protected!
    @thing = Thing.create(params[:thing])
    redirect '/admin'
  end

  get '/suggestion' do
    @no_header = true
    @thing = Thing.new
    erb :suggestion
  end

  post '/suggestion' do 
    @thing = Thing.create(params[:thing])
    flash[:notice] = "Thanks for the suggestion!"
    redirect '/'
  end

  get '/EAT' do 
    @things = Thing.where(suggestion:false, :tags => 'EAT').sort(:votes.desc)
    erb :index
  end

  get '/SEE' do 
    @things = Thing.where(suggestion:false, :tags => 'SEE').sort(:votes.desc)
    erb :index
  end

  get '/DO' do 
    @things = Thing.where(suggestion:false, :tags => 'DO').sort(:votes.desc)
    erb :index
  end

  get '/:id/vote-up' do |id|
    @thing = Thing.find(id)
    @thing.votes += 1
    @thing.save
    redirect '/'
  end

  get '/:id/vote-down' do |id|
    @thing = Thing.find(id)
    @thing.votes == 0 ? @thing.votes = 0 : @thing.votes -= 1
    @thing.save
    redirect '/'
  end

  get '/:id/approve' do |id|
    protected!
    @thing = Thing.find(id)
    @thing.suggestion = false
    @thing.save
    redirect '/admin'
  end

  get '/:id/complete' do |id|
    protected!
    @thing = Thing.find(id)
    @thing.completed = true
    @thing.save
    redirect '/admin'
  end

  get '/:id/delete' do |id|
    protected!
    @thing = Thing.find(id)
    @thing.destroy unless @thing.nil?
    redirect '/admin'
  end

  get '/:id' do |id|
    @thing = Thing.find(id)
    erb :thing
  end

  not_found { erb :'404' }
end

