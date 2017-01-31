module ViewObject
  class Engine < ::Rails::Engine
    config.autoload_paths += %W(#{config.root}/app/view_objects)
  end
end
