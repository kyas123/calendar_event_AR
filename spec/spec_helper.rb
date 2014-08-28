require 'bundler/setup'
Bundler.require(:default, :test)
require "event"

Dir[File.dirname(__FILE__) + '/../lib/*.rb'].each { |file| require file }

RSpec.configure do |config|
  config.after(:each) do
    Event.all.each { |events| events.destroy }
  end
end
