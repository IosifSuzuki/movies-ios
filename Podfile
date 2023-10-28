# Uncomment the next line to define a global platform for your project
platform :ios, '15.0'

# ignore all warnings from all dependencies
inhibit_all_warnings!

def swinject_pods
  pod 'Swinject', '~> 2.0'
end

def rx_pods
  pod 'RxSwift', '~> 6.0'
  pod 'RxCocoa', '~> 6.0'
end

target 'Movie' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Movie

  swinject_pods
  rx_pods

end
