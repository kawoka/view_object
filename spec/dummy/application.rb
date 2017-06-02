require 'action_controller/railtie'
require 'active_record'
require "view_object"

module Dummy
  class Application < Rails::Application
    config.secret_token = 'abcdefghijklmnopqrstuvwxyz0123456789'
    config.secret_key_base = 'abcdefghijklmnopqrstuvwxyz0123456789'
    config.eager_load = false
    ::ViewObject.configure do |config|
      config.routes_path = 'actions/'
    end
  end
end

Dummy::Application.initialize!

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: ':memory:'
)

#
# Migrates
#

class CreateTests < ActiveRecord::Migration
  def change
    create_table :tests do |t|
      t.timestamps null: false
    end
  end
end

class CreateHoges < ActiveRecord::Migration
  def change
    create_table :hoges do |t|
      t.timestamps null: false
    end
  end
end

CreateTests.new.change
CreateHoges.new.change

#
# Routes
#

Dummy::Application.routes.draw do
  resources :tests
  resources :hoges
end

#
# Controllers
#

class ApplicationController < ActionController::Base; end

class TestsController < ApplicationController
  include ::ViewObject
  view_object_only :index
  view_object_ignore :show
  def index
  end

  def show; end
end

class HogesController < ApplicationController
  include ::ViewObject

  def index; end

  def show; end
end

module Actions
  module Tests
    class IndexViewObject
      def initialize
        @is_called_before_render = false
      end

      def title
        'test index by view object'
      end

      def before_render
        @is_called_before_render = true
      end

      def called_before_render?
        @is_called_before_render
      end
    end
  end

  module Hoges
    class IndexViewObject
      def initialize
        @is_called_before_render = false
      end

      def title
        'hoge index by view object'
      end

      def before_render
        @is_called_before_render = true
      end

      def called_before_render?
        @is_called_before_render
      end
    end
  end
end
