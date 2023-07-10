platform :ios, '13.0'

target 'KindeAuth' do
  use_frameworks!

  # Pods for KindeAuth
  pod 'SwiftLint', '~> 0.50.3'
  pod 'KindeSDK', :git => 'https://github.com/kinde-oss/kinde-sdk-ios.git'

  target 'KindeAuthTests' do
    inherit! :search_paths
    pod 'Quick'
    pod 'Nimble'
    pod 'MockingbirdFramework'
  end

  target 'KindeAuthUITests' do
    # Pods for testing
  end

end

target 'KindeAuthUIKit' do
  use_frameworks!

  # Pods for KindeAuth
  pod 'SwiftLint', '~> 0.50.3'
  pod 'KindeSDK', :git => 'https://github.com/kinde-oss/kinde-sdk-ios.git'

end

post_install do |installer|
    installer.generated_projects.each do |project|
          project.targets.each do |target|
              target.build_configurations.each do |config|
                  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
               end
          end
   end
end
