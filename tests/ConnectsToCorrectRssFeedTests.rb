require 'test/unit'
require 'rspec/expectations'
require_relative '../lib/AwsStatus'

class ConnectToCorrectRssFeedTests < Test::Unit::TestCase
	include RSpec::Matchers

	def test_eu_west_1_sqs_status_rss_feed
		AwsStatus.new(self)
			.status
			.eu_west_1
			.simple_queue_service

		expect(@uri).to eql('http://status.aws.amazon.com/rss/sqs-eu-west-1.rss')
	end

	def test_eu_central_1_sqs_status_rss_feed
		AwsStatus.new(self)
			.status
			.eu_central_1
			.simple_queue_service

		expect(@uri).to eql('http://status.aws.amazon.com/rss/sqs-eu-central-1.rss')
	end

	def test_us_east_1_sqs_status_rss_feed
		AwsStatus.new(self)
			.status
			.us_east_1
			.simple_queue_service

		expect(@uri).to eql('http://status.aws.amazon.com/rss/sqs-us-east-1.rss')
	end

	def test_us_west_1_sqs_status_rss_feed
		AwsStatus.new(self)
			.status
			.us_west_1
			.simple_queue_service

		expect(@uri).to eql('http://status.aws.amazon.com/rss/sqs-us-west-1.rss')
	end

	def test_us_west_2_sqs_status_rss_feed
		AwsStatus.new(self)
			.status
			.us_west_2
			.simple_queue_service

		expect(@uri).to eql('http://status.aws.amazon.com/rss/sqs-us-west-2.rss')
	end

	def test_sa_east_1_sqs_status_rss_feed
		AwsStatus.new(self)
			.status
			.sa_east_1
			.simple_queue_service

		expect(@uri).to eql('http://status.aws.amazon.com/rss/sqs-sa-east-1.rss')
	end

	def test_ap_southeast_1_sqs_status_rss_feed
		AwsStatus.new(self)
			.status
			.ap_southeast_1
			.simple_queue_service

		expect(@uri).to eql('http://status.aws.amazon.com/rss/sqs-ap-southeast-1.rss')
	end

	def test_ap_southeast_2_sqs_status_rss_feed
		AwsStatus.new(self)
			.status
			.ap_southeast_2
			.simple_queue_service

		expect(@uri).to eql('http://status.aws.amazon.com/rss/sqs-ap-southeast-2.rss')
	end

	def test_ap_northeast_1_sqs_status_rss_feed
		AwsStatus.new(self)
			.status
			.ap_northeast_1
			.simple_queue_service

		expect(@uri).to eql('http://status.aws.amazon.com/rss/sqs-ap-northeast-1.rss')
	end

	def test_eu_west_1_sns_status_rss_feed
		AwsStatus.new(self)
			.status
			.eu_west_1
			.simple_notification_service

		expect(@uri).to eql('http://status.aws.amazon.com/rss/sns-eu-west-1.rss')
	end

	def test_eu_west_1_s3_status_rss_feed
		AwsStatus.new(self)
			.status
			.eu_west_1
			.simple_storage_service

		expect(@uri).to eql('http://status.aws.amazon.com/rss/s3-eu-west-1.rss')
	end
	
	def get(uri)
		@uri = uri
		nil
	end
end

