require 'simple-rss'
require_relative './OperatingNormallySpecification'

class ServiceStatusResponse
	attr_reader :message, :state

	def initialize(message, state)
		@message = message
		@state = state
	end

	def self.create(feedHtml)
		return NoServiceStatusResponse.new if feedHtml.nil?
		rssFeed = SimpleRSS.parse(feedHtml)
		if OperatingNormallySpecification.is_satisified_by? rssFeed.items
			ServiceOkayResponse.new
		else 
			ServiceErrorResponse.new(rssFeed.items.first[:title])
		end
	end
end

class ServiceOkayResponse < ServiceStatusResponse
	def initialize
		super(message='Service Operating Normally', state=:okay)
	end
end

class ServiceErrorResponse < ServiceStatusResponse
	def initialize(message)
		super(message, state=:error)
	end
end

class NoServiceStatusResponse < ServiceStatusResponse
	def initialize
		super(message='Cannot retrieve service status', state=:warning)
	end
end