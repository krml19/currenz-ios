# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Currenz' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Currenz
  # Rx
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'RxGesture'
  pod 'RxSwiftExt'
  pod 'Action'
  pod 'RxOptional'
  pod 'RxDataSources'
  
  # Logger
  pod 'SwiftyBeaver'
  # Network
  pod 'Moya/RxSwift'
  # Linter
  pod 'SwiftLint'
  # UI
  pod 'ChameleonFramework'
  pod 'Reusable'
  pod 'NVActivityIndicatorView'
  # Utils
  pod 'R.swift'
  
  target 'CurrenzTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'CurrenzUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '4.0'
        end
    end
end
