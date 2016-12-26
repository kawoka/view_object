module ViewObject

  class Dispatcher

    # @brief : Route毎にViewObjectをControllerとViewにDispatchする
    def self.dispatch_view_object(controller)
      @view_object = make_view_object(controller)
      controller.instance_variable_set(
        :@view_object,
        @view_object
      )
    end

    def self.callback method
      return if @view_object.blank?
      return unless @view_object.respond_to?(method)

      @view_object.send(method)
    end

    def self.before_render
      callback 'before_render'
    end

    def self.make_view_object(controller)

      name = vo_class_name(controller)
      vo_class = ActiveSupport::Dependencies.constantize(name)
      vo = vo_class.new

      vo.instance_variable_set(
        :@controller,
        controller
      )

      #do callback
      if vo.respond_to?(:after_initalize)
        vo.after_initalize
      end

      vo

    end

    def self.vo_class_name(controller)
      route_path = ViewObject.config.routes_path

      if route_path.present? && route_path.last != '/'
        route_path += '/'
      end
      paths = route_path + controller.params[:controller] + '/' + controller.params[:action]
      ret = paths.split('/').map { | path | path.camelcase }.join('::')
      ret += 'ViewObject'
      ret
    end

  end

end

