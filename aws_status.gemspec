Gem::Specification.new do |spec|
  spec.name        = 'aws_status'
  spec.version     = '1.0.2'
  spec.summary     = "Retrieve status of aws services"
  spec.authors     = ["iainjmitchell"]
  spec.email       = 'iainjmitchell@gmail.com'
  spec.files       = Dir.glob("lib/**/*")
  spec.homepage    = 'https://github.com/iainjmitchell/aws_status'
  spec.license       = 'MIT'
  spec.add_runtime_dependency 'httparty' 
  spec.add_runtime_dependency 'simple-rss' 
end