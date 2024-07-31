platform :ios, '18.0'
use_frameworks!
  
flutter_application_path = './translation_app_flutter'
load File.join(flutter_application_path, '.ios', 'Flutter', 'podhelper.rb')

target 'Translation_API_UIKit_Sample' do
  install_all_flutter_pods(flutter_application_path)

  post_install do |installer|
    flutter_post_install(installer) if defined?(flutter_post_install)
  end

  # Pods for Translation_API_UIKit_Sample
  target 'Translation_API_UIKit_SampleTests' do
  end
  
  target 'Translation_API_UIKit_SampleUITests' do
    # Pods for testing
  end
end
