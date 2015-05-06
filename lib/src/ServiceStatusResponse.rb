require 'simple-rss'

class ServiceStatusResponse
	attr_reader :message, :state

	def initialize(message, state)
		@message = message
		@state = state
	end

	def self.create(feedHtml)
		if feedHtml.nil?
			NoServiceStatusResponse.new 
		else
			rssFeed = SimpleRSS.parse(feedHtml)
			rssFeed.items.empty? ? 
				NoServiceEventsResponse.new : 
				ServiceStatusResponse.new(rssFeed.items.first[:title], :error)
		end 
	end
end

class NoServiceEventsResponse < ServiceStatusResponse
	def initialize
		super(message='Service Operating Normally', state=:okay)
	end
end

class NoServiceStatusResponse < ServiceStatusResponse
	def initialize
		super(message='Cannot retrieve service status', state=:warning)
	end
end