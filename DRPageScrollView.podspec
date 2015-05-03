Pod::Spec.new do |s|
  s.name                  = "DRPageScrollView"
  s.version               = "1.0.0"
  s.summary               = "Block-driven paginated scroll views"
  s.homepage              = "http://github.com/Dromaguirre/DRPageScrollView"
  s.author                = { "David Roman" => "dromaguirre@gmail.com" }
  s.license               = { :type => 'MIT', :file => 'LICENSE' }

  s.platform              = :ios, '8.0'
  s.ios.deployment_target = '8.0'

  s.source                = { :git => "https://github.com/Dromaguirre/DRPageScrollView.git", :tag => s.version.to_s }
  s.source_files          = 'DRPageScrollView/*.{h,m}'
  s.frameworks            = 'Foundation', 'UIKit'
  s.requires_arc          = true
end
