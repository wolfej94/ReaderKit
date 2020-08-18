Pod::Spec.new do |spec|

  spec.name         = "ReaderKit"
  spec.version      = "0.23"
  spec.license      = "MIT"
  spec.summary      = "A swift library for quickly integrating a built in camera session into your app."
  spec.homepage     = "https://github.com/appoly/ReaderKit"
  spec.authors = "James Wolfe"
  spec.source = { :git => 'https://github.com/appoly/ReaderKit.git', :tag => spec.version }

  spec.ios.deployment_target = "13.0"
  spec.framework = "UIKit"
  spec.framework = "Vision"
  spec.framework = "AVFoundation"
  spec.framework = "CoreImage"

  spec.swift_versions = ["5.0", "5.1"]
  
  spec.source_files = "Sources/ReaderKit/*.swift"
  

end
