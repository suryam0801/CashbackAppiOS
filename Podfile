# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'CashbackAppiOS' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for CashbackAppiOS

pod 'Firebase/Analytics'
pod 'Firebase/Database'
pod 'Firebase/Storage'
pod 'Firebase/Messaging'
pod 'Firebase/Auth'
pod 'CodableFirebase'
pod 'SDWebImageSwiftUI'
pod 'Branch'
pod "Introspect"
pod 'Firebase/Crashlytics'
pod 'Firebase/Analytics'
pod 'ConcentricOnboarding'
pod 'razorpay-pod', '~> 1.1.7'
pod 'MaterialComponents/Chips'

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
    end
  end
end

end
