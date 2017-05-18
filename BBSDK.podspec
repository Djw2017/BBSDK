

Pod::Spec.new do |s|

  s.name         = "BBSDK"
  s.version      = "1.0.8"
  s.summary      = "BBSDK is the foundation of all BabyBus SDKs"

  s.description  = <<-DESC
                        BBSDK 是一个基础SDK，提供一些基本方法、宏等等，所有SDK都可能用到此SDK，其本身不实现任何具体功能。
                   DESC

  s.homepage     = "https://coding.net/u/Dongjw_/p/BBSDK/git"
 
  s.license      = {:type => "MIT",:file => "LICENSE"}

  s.author             = { "Dong JW" => "1971728089@qq.com" }
 
  s.platform     = :ios, "7.0"

  s.source       = { :git => "https://git.coding.net/Dongjw_/BBSDK.git" }


  s.source_files  = "BBSDK/*.{h,m}"
  # ,"BBSDK/Utility/*.{h,m}","BBSDK/Categories/Foundation/*.{h,m}","BBSDK/Categories/UIKit/*.{h,m}","BBSDK/Macros/*.h"


  s.subspec 'Macros' do |macros|
    macros.source_files = 'BBSDK/Macros/**/*'
    macros.public_header_files = 'BBSDK/Macros/**/*.h'
   end

  s.subspec 'Categories' do |categories|

    categories.subspec 'Foundation' do |foundation|
      foundation.source_files = 'BBSDK/Categories/Foundation/*'
      foundation.public_header_files = 'BBSDK/Categories/Foundation/*.h'
    end
  end

  s.subspec 'Utility' do |utility|
    utility.source_files = 'BBSDK/Utility/**/*'
    utility.public_header_files = 'BBSDK/Utility/**/*.h'
    utility.dependency 'BBSDK/Macros'
    utility.dependency 'BBSDK/Categories'
  end


  s.frameworks = "UIKit", "ImageIO"

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

end
