require 'test/unit'
require 'rspec/expectations'
require_relative '../lib/aws_status'

class ReturnsCorrectStatusTests < Test::Unit::TestCase
	include RSpec::Matchers

	def test_no_incidents_returns_service_operating_normally_status
		@aws_status_response = 
			'<?xml version="1.0" encoding="UTF-8"?>
			<rss version="2.0">
			  <channel>
			    <title>Amazon CloudSearch (Frankfurt) Service Status</title>
			    <link>http://status.aws.amazon.com/</link>
			    <link rel="alternate" href="http://status.aws.amazon.com/rss/all.rss" type="application/rss+xml" title="Amazon Web Services Status Feed"/>
			    <title type="text">Current service status feed for Amazon CloudSearch (Frankfurt).</title>
			    <language>en-us</language>
			    <pubDate>Sun, 26 Apr 2015 09:38:06 PDT</pubDate>
			    <updated>Sun, 26 Apr 2015 09:38:06 PDT</updated>
			    <generator>AWS Service Health Dashboard RSS Generator</generator>
			    <ttl>5</ttl>
			  </channel>
			</rss>'

		response = AwsStatus.new(self)
			.status
			.eu_west_1
			.cloudsearch
		expect(response.message).to eql('Service Operating Normally')
		expect(response.state).to eql(:okay)
	end

	def test_one_error_incident_returns_error_state
		error_message= "Informational message: Increased error rates#{rand(0..100)}"
		@aws_status_response = 
			'<?xml version="1.0" encoding="UTF-8"?>
			<rss version="2.0">
			  <channel>
			    <title>Amazon Simple Queue Service (Ireland) Service Status</title>
			    <link>http://status.aws.amazon.com/</link>
			    <link rel="alternate" href="http://status.aws.amazon.com/rss/all.rss" type="application/rss+xml" title="Amazon Web Services Status Feed"/>
			    <title type="text">Current service status feed for Amazon Simple Queue Service (Ireland).</title>
			    <language>en-us</language>
			    <pubDate>Sun, 26 Apr 2015 10:14:06 PDT</pubDate>
			    <updated>Sun, 26 Apr 2015 10:14:06 PDT</updated>
			    <generator>AWS Service Health Dashboard RSS Generator</generator>
			    <ttl>5</ttl>        
				 <item>
				  <title type="text">'+error_message+'</title>
				  <link>http://status.aws.amazon.com/</link>
				  <pubDate>Thu, 23 Apr 2015 03:12:02 PDT</pubDate>
				  <guid>http://status.aws.amazon.com/#sqs-eu-west-1_1429783922</guid>
				  <description>We can confirm increased error rates for Send and Receive API calls in the EU-WEST-1 Region and continue to work towards resolution.</description>
				 </item>
			  </channel>
			</rss>'

		response = AwsStatus.new(self)
			.status
			.eu_west_1
			.simple_queue_service
		expect(response.message).to eql(error_message)
		expect(response.state).to eql(:error)
	end

	def test_one_error_resolved_incident_returns_service_operating_normally_status
		message= "Service is operating normally: [RESOLVED] Increased error rates#{rand(0..100)}"
		@aws_status_response = 
			'<?xml version="1.0" encoding="UTF-8"?>
			<rss version="2.0">
			  <channel>
			    <title>Amazon Simple Queue Service (Ireland) Service Status</title>
			    <link>http://status.aws.amazon.com/</link>
			    <link rel="alternate" href="http://status.aws.amazon.com/rss/all.rss" type="application/rss+xml" title="Amazon Web Services Status Feed"/>
			    <title type="text">Current service status feed for Amazon Simple Queue Service (Ireland).</title>
			    <language>en-us</language>
			    <pubDate>Sun, 26 Apr 2015 10:14:06 PDT</pubDate>
			    <updated>Sun, 26 Apr 2015 10:14:06 PDT</updated>
			    <generator>AWS Service Health Dashboard RSS Generator</generator>
			    <ttl>5</ttl>        
				<item>
	  				<title type="text">'+message+'</title>
	  				<link>http://status.aws.amazon.com/</link>
	  				<pubDate>Thu, 23 Apr 2015 03:44:04 PDT</pubDate>
	  				<guid>http://status.aws.amazon.com/#sqs-eu-west-1_1429785844</guid>
	  				<description>Between 2:22 AM PDT and 3:26 AM PDT SQS experienced elevated API error rates for Send and Receive API calls. We have resolved the issue and the service is operating normally.</description>
	 			</item>
			  </channel>
			</rss>'

		response = AwsStatus.new(self)
			.status
			.eu_west_1
			.simple_queue_service
		expect(response.message).to eql('Service Operating Normally')
		expect(response.state).to eql(:okay)
	end

	def get(uri)
		@aws_status_response
	end
end