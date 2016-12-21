module ViewObject
  class Engine < ::Rails::Engine
    config.autoload_paths += Dir["#{config.root}/app/view_objects"]
  end
end
