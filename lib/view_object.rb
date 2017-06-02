module ViewObject
  extend ActiveSupport::Concern
  @@view_object_ignore = nil
  @@view_object_only = nil

  included do
    define_callbacks :render
    before_render {view_object_before_render(self)}
    before_action {dispatch_view_object(self)}
  end

  def dispatch_view_object(controller)
    return unless is_view_object_only_action(@@view_object_only, controller)
    return if is_view_object_ignore_action(@@view_object_ignore, controller)
    # dispatch actions
    Dispatcher.dispatch_view_object(controller)
  end

  def is_view_object_only_action(actions, controller)
    only_actions = actions.is_a?(Array) ? actions.map{ |action| action.to_s } : actions.to_s
    return (only_actions.blank? || only_actions.include?(controller.params[:action].to_s))
  end

  def is_view_object_ignore_action(actions, controller)
    ignore_actions = actions.is_a?(Array) ? actions.map{ |action| action.to_s } : actions.to_s
    return (ignore_actions.present? && ignore_actions.include?(controller.params[:action].to_s))
  end

  def view_object_before_render(controller)
    vo = controller.instance_variable_get(:@view_object)
    return if vo.blank?
    return unless vo.respond_to?(:before_render)
    vo.send(:before_render)
  end

  def render(*options, &block)
    run_callbacks(:render) do
      super
    end
  end

  class_methods do
    def before_render(*names, &block)
      _insert_callbacks(names, block) do |name, options|
        set_callback(:render, :before, name, options)
      end
    end

    def view_object_only(*actions)
      @@view_object_only = actions
    end

    def view_object_ignore(*actions)
      @@view_object_ignore = actions
    end
  end
end

require 'view_object/config'
require 'view_object/engin'
require 'view_object/dispatcher'
