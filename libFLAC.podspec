Pod::Spec.new do |s|
  s.name         = "libFLAC"
  s.version      = "1.3.1"
  s.summary      = "Free Lossless Audio Codec library"

  s.description  = <<-DESC
                   Xiph's C-based Free Lossless Audio Codec library, packaged for iOS.
                   Packaged with or without Ogg support
                   DESC

  s.homepage     = "https://xiph.org/flac/"

  s.license      = { :type => "BSD", :file => "flac/COPYING" }

  s.author             = { "Yehor Popovych (packager)" => "popovych.yegor@gmail.com" }
  s.social_media_url   = "https://planet.xiph.org/"

  s.platform     = :ios, "6.0"

  s.source       = { :git => "https://github.com/ypopovych/flac-ios.git",
                     :tag => "master",
                     :submodules => true }

  #s.compiler_flags = "-O3",
  #                   "-Wno-conversion"
                     
  s.requires_arc = false

  s.source_files = "flac/src/libFLAC",
                   "flac/include/FLAC/*.h",
                   "no-ogg/config.h"
        
  s.public_header_files = "flac/include/FLAC/*.h", "no-ogg/config.h"
  
  s.header_dir = "FLAC"
  
  s.subspec 'Ogg' do |ogg|
  	ogg.source_files = "with-ogg/config.h"
  	ogg.public_header_files = "with-ogg/config.h"
  	ogg.dependency "libogg", "~>1.3.0"
  end
  
end


