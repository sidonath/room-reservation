$:.unshift __dir__ + '/..'
require 'rubygems'
require 'bundler'
Bundler.require(:default, :test)
require 'rspec'
require 'capybara/rspec'
require 'application'

module RSpec
  module FeatureExampleGroup
    def self.included(group)
      group.metadata[:type] = :feature
      Capybara.app = Application
    end
  end
end

RSpec.configure do |c|
  def c.escaped_path(*parts)
    Regexp.compile(parts.join('[\\\/]') + '[\\\/]')
  end

  c.color = true

  c.include RSpec::FeatureExampleGroup, type: :feature, example_group: {
    file_path: c.escaped_path(%w[spec features])
  }

  c.include Capybara::DSL, type: :feature
end