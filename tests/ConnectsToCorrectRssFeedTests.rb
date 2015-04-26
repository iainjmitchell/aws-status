require 'test/unit'
require 'rspec/expectations'

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

	DATA_CENTERS.each do |data_center_name, rss_name|
		define_method data_center_name do
			DataCenter.new(@rest_client, rss_name)
		end
	end
end

class DataCenter
	AWS_STATUS_RSS_ROOT = 'http://status.aws.amazon.com/rss'
	SERVICES = {	
		:cloudsearch => 'cloudsearch',
		:cloudwatch => 'cloudwatch',
		:dynamodb => 'dynamodb',
		:elastic_compute_cloud => 'ec2',
		:elastic_load_balancer => 'elb',
		:elastic_map_reduce => 'emr',
		:elasticache => 'elasticache',
		:glacier => 'glacier',
		:kinesis => 'kinesis',
		:redshift => 'redshift',
		:relational_database_service => 'rds',
		:simple_email_service => 'ses',
		:simple_queue_service => 'sqs',
		:simple_notification_service => 'sns',
		:simple_storage_service => 's3',
		:simple_workflow_service => 'swf',
		:simpledb => 'simpledb',
		:virtual_private_cloud =>'vpc',
		:auto_scaling => 'autoscaling',
		:cloudformation => 'cloudformation',
		:cloudhsm => 'cloudhsm',
		:cloudtrail => 'cloudtrail',
		:config => 'config',
		:direct_connect => 'directconnect',
		:elastic_beanstalk => 'elasticbeanstalk',
		:identity_and_access => 'iam',
		:key_management_service => 'kms',
		:storage_gateway => 'storagegateway'
	}

	def initialize(rest_client, location)
		@location = location
		@rest_client = rest_client
	end

	SERVICES.each do |service_name, rss_name|
		define_method service_name do
			status_for rss_name
		end
	end

	private

	def status_for(component)
		@rest_client.get("#{AWS_STATUS_RSS_ROOT}/#{component}-#{@location}.rss")
	end
end