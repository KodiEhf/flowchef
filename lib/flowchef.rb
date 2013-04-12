require "flowchef/version"
require "chef/handler"
require "flowdock"

#
# Provides a Chef exception handler so you can send information about
# chef-client failures to a Flowdock team inbox.
#
# Docs: http://wiki.opscode.com/display/chef/Exception+and+Report+Handlers
#
# Install - add the following to your client.rb:
#   require 'flowchef'
#   flowchef_handler = Flowchef::NotifyInbox.new(:api_token = "token",
#                                                :tags = [])
#   exception_handlers << flowchef_handler
#

module Flowchef
  class NotifyInbox < Chef::Handler
    class InvalidParameterError < StandardError; end
    def initialize(options = {})
      @api_token = if options[:api_token].kind_of?(Array)
                     options[:api_token]
                   else
                     options[:api_token].to_s
                   end
      raise InvalidParameterError, "Must specify a Flow token" if blank?(@api_token)
      # Emacs indented this oddly
      @tags = if options[:tags].kind_of?(Array)
                options[:tags].each do |tag|
          raise InvalidParameterError, "Tags must be strings" if not tag.kind_of?(String)
        end
              end
    end
    
    def report
      msg = <<-eos 
             <h2>Chef failuers on #{node.name}</h2>
             #{run_status.formatted_exception}
            eos
      flow = Flowdock::Flow.new(:api_token => @api_token,
                                :source => "chef-#{node.environment}",
                                :from => {:name => "Node #{node.fqdn}",
                                  :address => "noreply@#{node.fqdn}"})
      flow.push_to_team_inbox(:subject => "Chef failuers on #{node.name}",
                              :content => msg,
                              :tags => @tags)
    end

    def blank?(var)
      var.nil? || var.respond_to?(:length) && var.length == 0
    end
  end
end
