Pod::Spec.new do |spec|

  spec.name         = "QR-Code-Scanner-iOS"
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
  spec.source       = { :git => "https://github.com/AppliedRecognition/QR-Code-Scanner-iOS.git", :commit => "56ef39fb0167f9b9e1c1a3db7a6fcb6621af7438" }
  spec.source_files = "QR Code Scanner/*.swift"
  spec.resources    = "QR Code Scanner/**/*.{storyboard,strings}", "QR Code Scanner/*.xcassets"
  spec.swift_version = "5"

  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #

  # spec.framework  = "SomeFramework"
  # spec.frameworks = "SomeFramework", "AnotherFramework"

  # spec.library   = "iconv"
  # spec.libraries = "iconv", "xml2"


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.

  # spec.requires_arc = true

  # spec.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # spec.dependency "JSONKit", "~> 1.4"

end
