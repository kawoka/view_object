module ViewObject
  extend ActiveSupport::Concern
  included do
    before_action {dispatch_view_object(self)}
  end

  def dispatch_view_object(controller)
    Dispatcher.dispatch_view_object(controller)
  end

end

require 'view_object/config'
require 'view_object/engin'
require 'view_object/dispatcher'


