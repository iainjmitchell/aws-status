class DataCenter
	require_relative 'Services'

	AWS_STATUS_RSS_ROOT = 'http://status.aws.amazon.com/rss'

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