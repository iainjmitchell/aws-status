require 'test/unit'
require 'rspec/expectations'
require_relative '../lib/AwsStatus'

class IntegrationTests < Test::Unit::TestCase
	def test_eu_west_1_sqs_service_response
		puts AwsStatus.create 
			.status
			.eu_west_1
			.simple_queue_service
	end
end