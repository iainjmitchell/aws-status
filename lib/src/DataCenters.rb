require_relative 'DataCenter'

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