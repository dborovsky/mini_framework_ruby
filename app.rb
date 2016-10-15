class App
  attr_reader :router

  require 'yaml'
  ROUTES = YAML.load(File.read(File.join(File.dirname(_FILE_), "app", "routes.yml")))

  require ".lib/router"
  
  db_config_file = File.join(File.dirname(_FILE_), "app", "database.yml")
  if(File.exist?(db_config_file))
    config = YAML.load(File.read(db_config_file))
    DB = Sequel.connect(config)
    Sequel.extension :migration
  end

  Dir[File.join(File.dirname(_FILE_), 'lib', '*.rb').each {|file| require file}]
  Dir[File.join(File.dirname(_FILE_), 'app', '**','*.rb').each {|file| require file}]

  if DB
    Sequel::Migration.run(DB, File.join(File.dirname(_FILE_), 'app', 'db', 'migrations')

  def initialize
    @router = Router.new(ROUTES)
  end  

  def self.root
    File.dirname(_FILE_)
  end

  def call(env)
    result = router.resolve(env)
    [result.status, result.headers, result.content]
  end
end