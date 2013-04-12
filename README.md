# Flowchef

This gem can be used with Chef to send reports to a Flowdock channel
using the Flowdock Push API

## Installation

Add this line to your application's Gemfile:

    gem 'flowchef'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install flowchef

### Install on your chef client

We use a cookbook to manage our handlers, you can install this gem
in your own cookbook by adding this to your recipe.

    chef_gem "flowchef" do
	  action :install
	end

## Usage

You can use the [`chef_handler`](https://github.com/opscode-cookbooks/chef_handler) cookbook to
register it as so

    chef_handler "Flowchef::NotifyInbox" do
	  source    'flowchef'
	  arguments [:api_token => "Your Flow API Token",
	             :tags => ["array","of","tags"]]
	  supports  :exception => true
	  action    :enable
	end
