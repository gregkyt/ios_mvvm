platform :ios, '9.0'

target ‘SkyshiMVVM’ do
  use_frameworks!

  pod ‘Alamofire’
  pod ‘RxSwift’, ‘~> 4.1.2’
  pod ‘RxCocoa’, ‘~> 4.1.2’
  pod 'Firebase/Core'
  pod 'Firebase/Messaging'
  pod ‘Fabric’
  pod ‘Crashlytics’
  pod 'Localize-Swift'
  pod ‘SwiftyJSON’
  pod 'IQKeyboardManagerSwift'
  pod 'SDWebImage'
  pod ‘NVActivityIndicatorView’

  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        if config.name != 'Debug'
          config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = '-Owholemodule'
        else
          config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = '-Onone'
        end
      end
    end
  end

end
