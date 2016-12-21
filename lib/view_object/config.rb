require 'active_support/configurable'

module ViewObject

  def self.configure(&block)
    yield @config ||= ViewObject::Configuration.new
  end

  # Global settings for ViewObject
  def self.config
    @config
  end

  # need a Class for 3.0
  class Configuration #:nodoc:
    include ActiveSupport::Configurable
    config_accessor :routes_path

    def param_name
      config.param_name.respond_to?(:call) ? config.param_name.call : config.param_name
    end

    # define param_name writer (copied from AS::Configurable)
    writer, line = 'def param_name=(value); config.param_name = value; end', __LINE__
    singleton_class.class_eval writer, __FILE__, line
    class_eval writer, __FILE__, line
  end

  configure do |config|
    config.routes_path = '' #like 'hoge/pages'
  end
end
