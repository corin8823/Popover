Pod::Spec.new do |s|
  s.name             = "Popover"
  s.version          = "1.0.4"
  s.summary          = "Popover is a balloon library like facebook app. It is written in pure swift."
  s.homepage         = "https://github.com/corin8823"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = { :type => "MIT", :file => "LICENSE" }
  s.author           = { "corin8823" => "yusuke.t88@gmail.com" }
  s.source           = { :git => "https://github.com/corin8823/Popover.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/corin8823'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Classes/*.swift'
  s.pod_target_xcconfig = {
    'SWIFT_VERSION' => '3.0',
  }
end
