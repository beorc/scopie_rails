class ScopieRails::Engine < ::Rails::Engine
  config.autoload_paths += Dir["#{config.root}/app/scopies"]
end
