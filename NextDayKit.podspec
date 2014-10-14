Pod::Spec.new do |s|
  s.name         = "NextDayKit"
  s.version      = "0.1"
  s.summary      = "Client SDK for NextDay."
  s.homepage     = "https://github.com/nickcheng/NextDayKit"
  s.license      = {:type=>'MIT', :file=>"LICENSE"}
  s.author       = { "nickcheng" => "n@nickcheng.com" }
  s.source       = { :git => "https://github.com/nickcheng/NextDayKit.git", :tag => "0.1" }
  s.platform     = :ios, '6.0'
  s.source_files = 'NextDayKit/**/*.{h,m}'
  s.public_header_files = 'NextDayKit/**/*.h'
  s.requires_arc = true
  s.dependency 'NCWeibo', '~> 0.1'
  s.dependency 'SocketRocket'
end
