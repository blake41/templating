require 'bundler'
Bundler.require

Dir.glob('./lib/*.rb') do |model|
  require model
end

module Name
  class App < Sinatra::Application

    #configure
    configure do
      set :root, File.dirname(__FILE__)
      set :public_folder, 'public'
    end

    #database
    set :database, "sqlite3:///database.db"

    #filters

    #routes
# example of compiling coffee on the fly
    get '/application.js' do
      # content_type "text/javascript"
      coffee :application
    end

    get '/myroot' do
      erb :index
    end

    get "/root_coffee" do
      erb :root_coffee
    end

    get "/mysnip" do
      erb :mysnip#, :layout => false
    end

    get "/random" do
      id = [1,2].shuffle[0]
      @person = Person.find(id)
      haml :somehaml
    end

    get "/somehaml/:id" do
      id = params[:id]
      @person = Person.find(id)
      haml :somehaml
    end

    #helpers
    helpers do
      def partial(file_name)
        erb file_name, :layout => false
      end
    end

  end
end
