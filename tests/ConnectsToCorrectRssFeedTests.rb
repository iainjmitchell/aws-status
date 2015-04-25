require 'test/unit'
require 'rspec/expectations'

class ConnectToCorrectRssFeedTests < Test::Unit::TestCase
	include RSpec::Matchers

	def test_eu_west_1_sqs_status_rss_feed
		AwsStatus.new(self)
			.status
			.eu_west_1
			.sqs

		expect(@uri).to eql('http://status.aws.amazon.com/rss/sqs-eu-west-1.rss')
	end

	def test_eu_central_1_sqs_status_rss_feed
		AwsStatus.new(self)
			.status
			.eu_central_1
			.sqs

		expect(@uri).to eql('http://status.aws.amazon.com/rss/sqs-eu-central-1.rss')
	end

	def test_us_east_1_sqs_status_rss_feed
		AwsStatus.new(self)
			.status
			.us_east_1
			.sqs

		expect(@uri).to eql('http://status.aws.amazon.com/rss/sqs-us-east-1.rss')
	end

	def test_us_west_1_sqs_status_rss_feed
		AwsStatus.new(self)
			.status
			.us_west_1
			.sqs

		expect(@uri).to eql('http://status.aws.amazon.com/rss/sqs-us-west-1.rss')
	end

	def test_us_west_2_sqs_status_rss_feed
		AwsStatus.new(self)
			.status
			.us_west_2
			.sqs

		expect(@uri).to eql('http://status.aws.amazon.com/rss/sqs-us-west-2.rss')
	end

	def test_sa_east_1_sqs_status_rss_feed
		AwsStatus.new(self)
			.status
			.sa_east_1
			.sqs

		expect(@uri).to eql('http://status.aws.amazon.com/rss/sqs-sa-east-1.rss')
	end

	def test_ap_southeast_1_sqs_status_rss_feed
		AwsStatus.new(self)
			.status
			.ap_southeast_1
			.sqs

		expect(@uri).to eql('http://status.aws.amazon.com/rss/sqs-ap-southeast-1.rss')
	end

	def test_ap_southeast_2_sqs_status_rss_feed
		AwsStatus.new(self)
			.status
			.ap_southeast_2
			.sqs

		expect(@uri).to eql('http://status.aws.amazon.com/rss/sqs-ap-southeast-2.rss')
	end

	def test_ap_northeast_1_sqs_status_rss_feed
		AwsStatus.new(self)
			.status
			.ap_northeast_1
			.sqs

		expect(@uri).to eql('http://status.aws.amazon.com/rss/sqs-ap-northeast-1.rss')
	end

	def get(uri)
		@uri = uri
	end
end

class AwsStatus
	attr_reader :status

	def initialize(rest)
		@rest = rest
		@status = DataCenters.new(rest)
	end
end

class DataCenters 
	DATA_CENTERS = {
		:eu_west_1 => 'eu-west-1',
		:eu_central_1 => 'eu-central-1',
		:us_east_1 => 'us-east-1',
		:us_west_1 => 'us-west-1',
		:us_west_2 => 'us-west-2',
		:sa_east_1 => 'sa-east-1',
		:ap_northeast_1 => 'ap-northeast-1',
		:ap_southeast_1 => 'ap-southeast-1',
		:ap_southeast_2 => 'ap-southeast-2'
	}

	def initialize(rest_client)
		@rest_client = rest_client
	end

	DATA_CENTERS.each do |key, item|
		define_method key do
			DataCenter.new(@rest_client, item)
		end
	end
end

class DataCenter
	AWS_STATUS_RSS_ROOT = 'http://status.aws.amazon.com/rss'

	def initialize(rest_client, location)
		@location = location
		@rest_client = rest_client
	end

	def sqs
		status_for 'sqs'
	end

	private

	def status_for(component)
		@rest_client.get("#{AWS_STATUS_RSS_ROOT}/#{component}-#{@location}.rss")
	end
end