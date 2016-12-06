Pod::Spec.new do |s|
  s.name             = 'LocalPusher'
  s.version          = '1.0.0'
  s.summary          = 'Swift 3 Wrapper for UserNotification.'
 
  s.description      = <<-DESC
Swift 3 Wrapper for UserNotification.
                       DESC
 
  s.homepage         = 'https://github.com/TheAbstractDev/LocalPusher'
  s.license          = { :type => 'MIT' }
  s.author           = { "Sofiane Beors (TheAbstractDev)" => "theabstractdev@gmail.com" }
  s.source           = { :git => 'https://github.com/TheAbstractDev/LocalPusher', :tag => s.version.to_s }
 
  s.ios.deployment_target = '10.0'
  s.source_files = 'LocalPusher/*'
  s.framework     = "UserNotifications"
 
end