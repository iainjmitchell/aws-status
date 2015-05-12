# aws_status
A Gem that attempts to extract current status from amazon aws

##Introduction

Amazon currently do not have an API for getting the current status of the AWS services, they do however expose a RSS feed for each service in each region.  The purpose of this GEM is to make it easier to work out whether the service is currently up or down.

NOTE: recent downtimes suggest that when an issue occurs Amazon are very slow at updating the RSS feed and status page.  This Gem will only react to changes in the RSS feed at Amazons end.

##Installation

The package is installed on rubygems and can be installed using the following command

    gem install 'aws_status'

or adding the following to your Gemfile
    
    gem 'aws_status'

##Usage

```ruby
	require 'aws_status'

	# AwsStatus.create.status.[data_center].[service_name]
	current_status = AwsStatus.create 
		.status
		.eu_west_1
		.simple_queue_service

	puts current_status.state 
	# :okay or :error
	puts current_status.message
	# the current status message
```

##Supported Services

See [this](lib/src/Services.rb) file for a list of services that are supported

##Missing functionality

Some services are not hosted at individual data centers (e.g. route 53), so at the moment the status of these cannot be retrieved by this gem.
