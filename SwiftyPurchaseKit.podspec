#
# Be sure to run `pod lib lint SwiftyPurchaseKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#
# 1. new code update github
# 2. local not code : pod repo add SwiftyPurchaseKit  https://github.com/DanielZSY/SwiftyPurchaseKit.git
#    local uodate code: cd ~/.cocoapods/repos/SwiftyPurchaseKit. Then execute: pod repo update SwiftyPurchaseKit
# 3. pod repo push SwiftyPurchaseKit SwiftyPurchaseKit.podspec --allow-warnings --sources='https://github.com/CocoaPods/Specs.git'
# 4. pod trunk push SwiftyPurchaseKit.podspec --allow-warnings
# 5. pod install or pod update on you project execute

Pod::Spec.new do |s|
  s.name             = 'SwiftyPurchaseKit'
  s.version          = '0.0.1'
  s.summary          = 'SwiftyPurchaseKit'
  s.module_name      = 'SwiftyPurchaseKit'
  
  s.homepage         = 'https://github.com/DanielZSY/SwiftyPurchaseKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'DanielZSY' => 'DanielZSY@163.com' }
  s.source           = { :git => 'https://github.com/DanielZSY/SwiftyPurchaseKit.git', :tag => s.version.to_s }
  
  s.platform              = :ios, '10.0'
  s.swift_versions        = "5"
  s.ios.deployment_target = '10.0'
  s.pod_target_xcconfig   = { 'SWIFT_VERSION' => '5.0' }
  
  s.frameworks    = 'UIKit'
  s.libraries     = 'z', 'c++'
  s.source_files  = 'SwiftyPurchaseKit/**/*.{swift,h,m}'
  
  s.dependency 'SwiftyStoreKit'
end
