require "spec_helper"
describe ViewObject do
  it "has a version number" do
    expect(ViewObject::VERSION).not_to be nil
  end

  before(:each) do
    @mock_controller_class = Struct.new(:controller) do
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
    it 'dispatched' do
      expect(ViewObject::Dispatcher).to receive(:dispatch_view_object).exactly(1).times
      @mock_controller_class.view_object_only(:index)
      @mock_controller.dispatch_view_object(@mock_controller)
    end
    it 'dispatched' do
      expect(ViewObject::Dispatcher).to receive(:dispatch_view_object).exactly(1).times
      @mock_controller_class.view_object_only(:index, :show)
      @mock_controller.dispatch_view_object(@mock_controller)
    end
    it 'not dispatched' do
      expect(ViewObject::Dispatcher).to receive(:dispatch_view_object).exactly(0).times
      @mock_controller_class.view_object_only(:show)
      @mock_controller.dispatch_view_object(@mock_controller)
    end
    it 'not dispatched' do
      expect(ViewObject::Dispatcher).to receive(:dispatch_view_object).exactly(0).times
      @mock_controller_class.view_object_ignore(:index)
      @mock_controller.dispatch_view_object(@mock_controller)
    end
    it 'not dispatched' do
      expect(ViewObject::Dispatcher).to receive(:dispatch_view_object).exactly(0).times
      @mock_controller_class.view_object_only(:index)
      @mock_controller_class.view_object_ignore(:index)
      @mock_controller.dispatch_view_object(@mock_controller)
    end
  end

  describe 'validate store' do
    describe 'is only action' do
      it 'Symbol Array ok' do
        expect(@mock_controller.is_view_object_only_action([:index], @mock_controller)).to be true
      end

      it 'Symbol Array ok' do
        expect(@mock_controller.is_view_object_only_action([:index, :show], @mock_controller)).to be true
      end

      it 'Symbol ok' do
        expect(@mock_controller.is_view_object_only_action(:index, @mock_controller)).to be true
      end

      it 'String ok' do
        expect(@mock_controller.is_view_object_only_action('index', @mock_controller)).to be true
      end

      it 'Symbol Array ng' do
        expect(@mock_controller.is_view_object_only_action([:show], @mock_controller)).to be false
      end

      it 'Symbol Array ng' do
        expect(@mock_controller.is_view_object_only_action([:show, :edit], @mock_controller)).to be false
      end

      it 'Symbol ng' do
        expect(@mock_controller.is_view_object_only_action(:show, @mock_controller)).to be false
      end

      it 'String ng' do
        expect(@mock_controller.is_view_object_only_action('show', @mock_controller)).to be false
      end
    end

    describe 'is ignore action' do
      it 'Symbol Array ok' do
        expect(@mock_controller.is_view_object_ignore_action([:index], @mock_controller)).to be true
      end

      it 'Symbol Array ok' do
        expect(@mock_controller.is_view_object_ignore_action([:index, :show], @mock_controller)).to be true
      end

      it 'Symbol ok' do
        expect(@mock_controller.is_view_object_ignore_action(:index, @mock_controller)).to be true
      end

      it 'String ok' do
        expect(@mock_controller.is_view_object_ignore_action('index', @mock_controller)).to be true
      end

      it 'Symbol Array ng' do
        expect(@mock_controller.is_view_object_ignore_action([:show], @mock_controller)).to be false
      end

      it 'Symbol Array ng' do
        expect(@mock_controller.is_view_object_ignore_action([:show, :edit], @mock_controller)).to be false
      end

      it 'Symbol ng' do
        expect(@mock_controller.is_view_object_ignore_action(:show, @mock_controller)).to be false
      end

      it 'String ng' do
        expect(@mock_controller.is_view_object_ignore_action('show', @mock_controller)).to be false
      end
    end
  end
end
