class OperatingNormallySpecification
	RESOLVED_EVENT_EXPRESSION = /RESOLVED/

	def self.is_satisified_by?(service_events)
		service_events.empty? || service_events.first[:title] =~ RESOLVED_EVENT_EXPRESSION
	end
end