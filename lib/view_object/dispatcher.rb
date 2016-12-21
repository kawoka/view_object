module ViewObject

  class Dispatcher

    # @brief : Route毎にViewObjectをControllerとViewにDispatchする
    def self.dispatch_view_object(controller)
      controller.instance_variable_set(
        :@view_object,
        make_view_object(controller)
      )
    end

    def self.make_view_object(controller)
      name = vo_class_name(controller)
      vo = ActiveSupport::Dependencies.constantize(name)
      vo.new(
        controller: controller
      )
    end

    def self.vo_class_name(controller)
      paths = controller.params[:controller] + '/' + controller.params[:action]
      ret = paths.split('/').inject do | path, p |
        path.camelcase + '::' + p.camelcase
      end
      ret += 'ViewObject'
      ret
    end

  end

end
