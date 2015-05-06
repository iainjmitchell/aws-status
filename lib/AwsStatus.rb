require 'httparty'
require_relative './src/DataCenters'

class AwsStatus
	attr_reader :status

	def initialize(rest_client)
		@status = DataCenters.new(rest_client)
	end

	def self.create
		AwsStatus.new(RestClient)
	end
end

class RestClient
	def self.get(uri)
		HTTParty.get(uri).to_s
	end
end