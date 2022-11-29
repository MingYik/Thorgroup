# 公共仓库地址
source 'https://github.com/CocoaPods/Specs.git'
# platform :ios, '12.0'
platform :ios, '12.0'
# pods转Modular可直接Swift中import不需bridging-header桥接
use_modular_headers!
# 关闭全局警告
inhibit_all_warnings!

target 'Thorgroup' do

  # Rx响应式编程UI框架
  pod 'RxSwift'
  pod 'RxCocoa'
  # Rx网络请求库
  pod 'Moya/RxSwift', '~> 15.0'
  # 布局依赖库
  pod 'SnapKit'
  # 轻扫菜单Cell
  pod 'SwipeCellKit'
  # 网络图片库
  pod 'Kingfisher', '~> 7.0'
  # webp解码库
  pod 'KingfisherWebP', '~> 1.4.0'
  # 键盘控制
  pod 'IQKeyboardManagerSwift'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            # building for iOS Simulator, but linking in an object file built for iOS, for architecture 'arm64'
            config.build_settings['EXCLUDED_ARCHS[sdk=iphonesimulator*]'] = 'arm64'
            #不支持 BITCODE
            config.build_settings['ENABLE_BITCODE'] = 'NO'
            #解决swift模块问题
            config.build_settings['SWIFT_VERSION'] = '5.0' 
            #解决platform模块问题
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
        end
    end
end

