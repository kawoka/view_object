require "spec_helper"
describe ViewObject do
  it "has a version number" do
    expect(ViewObject::VERSION).not_to be nil
  end

  before(:each) do
    @mock_controller_class = class DummyController
      def params
        { action: 'index' }
      end

      def self.before_action
      end

      def self.define_callbacks(event)
      end

      def self.alias_method_chain(event, timing)
      end

      def self._insert_callbacks(event, timing)
      end

      include ViewObject
    end
    @mock_controller = @mock_controller_class.new
    ViewObject::Dispatcher
  end

  describe 'dispatch_view_object' do
    it 'dispatched' do
      expect(ViewObject::Dispatcher).to receive(:dispatch_view_object).exactly(1).times
      @mock_controller.dispatch_view_object(@mock_controller)
    end
    context 'only index' do
      it 'dispatched' do
        expect(ViewObject::Dispatcher).to receive(:dispatch_view_object).exactly(1).times
        @mock_controller_class.view_object_only(:index)
        @mock_controller.dispatch_view_object(@mock_controller)
      end
    end
    context 'only index, show' do
      it 'dispatched' do
        expect(ViewObject::Dispatcher).to receive(:dispatch_view_object).exactly(1).times
        @mock_controller_class.view_object_only(:index, :show)
        @mock_controller.dispatch_view_object(@mock_controller)
      end
    end

    context 'only show' do
      it 'not dispatched' do
        expect(ViewObject::Dispatcher).to receive(:dispatch_view_object).exactly(0).times
        @mock_controller_class.view_object_only(:show)
        @mock_controller.dispatch_view_object(@mock_controller)
      end
    end

    context 'ignore index' do
      it 'not dispatched' do
        expect(ViewObject::Dispatcher).to receive(:dispatch_view_object).exactly(0).times
        @mock_controller_class.view_object_ignore(:index)
        @mock_controller.dispatch_view_object(@mock_controller)
      end
    end
    context 'only index and ignore index' do
      it 'not dispatched' do
        expect(ViewObject::Dispatcher).to receive(:dispatch_view_object).exactly(0).times
        @mock_controller_class.view_object_only(:index)
        @mock_controller_class.view_object_ignore(:index)
        @mock_controller.dispatch_view_object(@mock_controller)
      end
    end
  end
end
