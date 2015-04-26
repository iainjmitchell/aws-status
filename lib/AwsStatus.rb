require 'httparty'
require_relative './src/DataCenters'

class AwsStatus
	attr_reader :status

	def initialize(rest_client)
		@status = DataCenters.new(rest_client)
	end

	def self.create
		AwsStatus.new(HTTParty)
	end
end