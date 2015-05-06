require 'test/unit'
require 'rspec/expectations'
require_relative '../lib/AwsStatus'

class IntegrationTests < Test::Unit::TestCase
	include RSpec::Matchers

	def test_eu_west_1_sqs_service_response
		response = AwsStatus.create 
			.status
			.eu_west_1
			.simple_queue_service
		expect(response.message.length).to be > 0
	end
end