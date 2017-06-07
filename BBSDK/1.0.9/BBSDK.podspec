

Pod::Spec.new do |s|

  s.name         = "BBSDK"
  s.version      = "1.0.9"
  s.summary      = "BBSDK is the foundation of all BabyBus SDKs"

  s.description  = <<-DESC
                        BBSDK 是一个基础SDK，提供一些基本方法、宏等等，所有SDK都可能用到此SDK，其本身不实现任何具体功能。
                   DESC

  s.homepage     = "https://github.com/Djw2017/BBSDK"
 
  s.license      = {:type => "MIT",:file => "LICENSE"}

  s.author             = { "Dong JW" => "1971728089@qq.com" }
 
  s.platform     = :ios, "7.0"

  s.source       = { :git => "https://github.com/Djw2017/BBSDK.git" }

  s.subspec 'Utility' do |utility|
    utility.source_files = 'BBSDK/Utility/*'
    utility.public_header_files = 'BBSDK/Utility/*.h'
    utility.dependency 'BBSDK/Categories/Foundation'
  end

  s.subspec 'Macros' do |macros|
    macros.source_files = 'BBSDK/Macros/*'
    macros.public_header_files = 'BBSDK/Macros/*.h'
    macros.dependency 'BBSDK/Utility'
  end

  s.subspec 'Categories' do |categories|

    categories.source_files = 'BBSDK/Categories/*.h'

    categories.subspec 'Foundation' do |foundation|
      foundation.source_files = 'BBSDK/Categories/Foundation/*'
      foundation.public_header_files = 'BBSDK/Categories/Foundation/*.h'
    end

    categories.subspec 'UIKit' do |uikit|
      uikit.source_files = 'BBSDK/Categories/UIKit/*'
      uikit.public_header_files = 'BBSDK/Categories/UIKit/*.h'
      uikit.dependency 'BBSDK/Categories/Foundation'
      uikit.dependency 'BBSDK/Utility'
    end

  end




  s.frameworks = "UIKit", "ImageIO"

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }

end
