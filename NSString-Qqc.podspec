Pod::Spec.new do |s|

  s.license      = "MIT"
  s.author       = { "qqc" => "20599378@qq.com" }
  s.platform     = :ios, "8.0"
  s.requires_arc  = true

  s.name         = "NSString-Qqc"
  s.version      = "1.0.64"
  s.summary      = "NSString-Qqc"
  s.homepage     = "https://github.com/xukiki/NSString-Qqc"
  s.source       = { :git => "https://github.com/xukiki/NSString-Qqc.git", :tag => "#{s.version}" }
  
  s.source_files  = ["NSString-Qqc/*.{h,m}"]
  s.dependency "NSData-Qqc"
  #s.dependency "AFNetworking", "~> 3.0"
end
