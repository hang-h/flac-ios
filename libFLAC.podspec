Pod::Spec.new do |s|
  s.name         = "libFLAC"
  s.version      = "1.3.1"
  s.summary      = "Free Lossless Audio Codec library"

  s.description  = <<-DESC
                   Xiph's C-based Free Lossless Audio Codec library, packaged for iOS.
                   Packaged with or without Ogg support
                   DESC

  s.homepage     = "https://xiph.org/flac/"

  s.license      = { :type => "Xiph", :file => "COPYING" }

  s.author             = { "Yehor Popovych (packager)" => "popovych.yegor@gmail.com" }
  s.social_media_url   = "https://planet.xiph.org/"

  s.platform     = :ios, "6.0"

  s.source       = { :git => "https://github.com/evature/flac-ios.git",
                     :tag => s.version,
                     :submodules => true }
  s.compiler_flags = "-DHAVE_CONFIG_H",
                     "-Wno-unused",
                     "-Wno-conversion"
                     
  s.requires_arc = false
  
  s.module_name = "FLAC"
  
  s.module_map = "libFLAC.modulemap"
  
  s.default_subspec = "Base" # Base version by default 
  
  # This is headers from include/share folder
  s.subspec 'CoreShareHeaders' do |sh|
  	sh.source_files = "flac/include/share/**/*.h"
  	sh.private_header_files = "flac/include/share/**/*.h"
  	sh.header_mappings_dir = "flac/include"
  	sh.requires_arc = false
  end
  
  # This is headers from src/libFLAC/include folder
  s.subspec 'CorePrivateHeaders' do |ph|
  	ph.source_files = "flac/src/libFLAC/include/**/*.h"
  	ph.private_header_files = "flac/src/libFLAC/include/**/*.h"
  	ph.header_mappings_dir = "flac/src/libFLAC/include"
  	ph.requires_arc = false
  end
  
  # Sourced of the library without Ogg
  s.subspec 'Base' do |core|
  	core.source_files = "flac/src/libFLAC/*.c",
                        "flac/include/FLAC/*.h",
                        "assert.h",
                        "no-ogg/config.h"
                    
    core.exclude_files = "flac/src/libFLAC/ogg*.c", 
                         "flac/include/FLAC/assert.h"
  	core.public_header_files = "flac/include/FLAC/*.h", 
  	                           "assert.h",
  	                           "no-ogg/config.h"
  	core.header_dir = "FLAC"
  	core.requires_arc = false
  
  	core.dependency "libFLAC/CoreShareHeaders"
  	core.dependency "libFLAC/CorePrivateHeaders"
  end
  
  
  
  # Config with Ogg and Ogg source files.
  #s.subspec 'Ogg' do |ogg|
  #	ogg.source_files = "with-ogg/config.h", "flac/src/libFLAC/ogg*.c"
  #	ogg.public_header_files = "with-ogg/config.h"
  #	ogg.requires_arc = false
  #	ogg.header_dir = "FLAC"
  #	
  #	ogg.dependency "libFLAC/Base"
  #	ogg.dependency "libogg", "~>1.3.0"
  #end
  
end


