Pod::Spec.new do |spec|

  spec.name         = "QR-Code-Scanner-iOS"
  spec.module_name  = "QRCodeScanner"
  spec.version      = "1.0.0"
  spec.summary      = "QR code camera"

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  spec.description  = "Provides view controller to scan QR codes"
  spec.homepage     = "https://github.com/AppliedRecognition/QR-Code-Scanner-iOS"
  spec.license      = "MIT"
  spec.author       = "Applied Recognition, Inc."
  spec.platform     = :ios, "11.0"
  spec.source       = { :git => "https://github.com/AppliedRecognition/QR-Code-Scanner-iOS.git", :tag => "v#{spec.version}" }
  spec.source_files = "QR Code Scanner/*.swift"
  spec.resources    = "QR Code Scanner/**/*.{storyboard,strings}", "QR Code Scanner/*.xcassets"
  spec.swift_version = "5"

end
