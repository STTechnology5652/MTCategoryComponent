#
# Be sure to run `pod lib lint MTCategoryComponent.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MTCategoryComponent'
  s.version          = '2.0.1'
  s.summary          = '常用的Category封装自己习惯快速上手的方法.'
  
  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  
  s.description      = <<-DESC
  TODO: Add long description of the pod here.
  DESC
  
  s.homepage         = 'https://github.com/Starup012/MTCategoryComponent.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Major Tom' => 'v2top1lyle@gmail.com' }
  s.source           = { :git => 'https://github.com/Starup012/MTCategoryComponent.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  
  s.ios.deployment_target = '9.0'
  
  s.source_files = 'MTCategoryComponent/Classes/MTCategoryComponentHeader.h'
  
  s.subspec 'Foundation' do |ss|
    ss.ios.deployment_target = '9.0'
    ss.source_files = 'MTCategoryComponent/Classes/Foundation/MTFoundationCategoryHeader.h'
    ss.subspec 'Sources' do |sss|
      sss.source_files = 'MTCategoryComponent/Classes/Foundation/Sources/*.{h,m}'
    end
    
  end
  
  s.subspec 'UIKit' do |ss|
    ss.ios.deployment_target = '9.0'
    ss.source_files = 'MTCategoryComponent/Classes/UIKit/MTUIKitExtensionHeader.h'
    
    ss.subspec 'UIColor' do |sss|
      sss.source_files = 'MTCategoryComponent/Classes/UIKit/UIColor/*.{h,m}'
    end
    ss.subspec 'UIControl' do |sss|
      sss.source_files = 'MTCategoryComponent/Classes/UIKit/UIControl/*.{h,m}'
    end
    ss.subspec 'UIFont' do |sss|
      sss.source_files = 'MTCategoryComponent/Classes/UIKit/UIFont/*.{h,m}'
    end
    ss.subspec 'UIImageView' do |sss|
      sss.source_files = 'MTCategoryComponent/Classes/UIKit/UIImageView/*.{h,m}'
    end
    ss.subspec 'UITableView' do |sss|
      sss.source_files = 'MTCategoryComponent/Classes/UIKit/UITableView/*.{h,m}'
    end
    ss.subspec 'UITextField' do |sss|
      sss.source_files = 'MTCategoryComponent/Classes/UIKit/UITextField/*.{h,m}'
    end
    ss.subspec 'UIView' do |sss|
      sss.source_files = 'MTCategoryComponent/Classes/UIKit/UIView/*.{h,m}'
      sss.dependency  'MTCategoryComponent/UIKit/UIColor'
      sss.dependency 'Masonry'
    end
    
    ss.subspec 'UIImage' do |sss|
      sss.source_files = 'MTCategoryComponent/Classes/UIKit/UIImage/*.{h,m}'
      sss.dependency  'MTCategoryComponent/UIKit/UIColor'
      sss.dependency  'MTCategoryComponent/UIKit/UIView'
      
      sss.frameworks = "UIKit", "Accelerate"
    end
    ss.subspec 'UIViewController' do |sss|
      sss.source_files = 'MTCategoryComponent/Classes/UIKit/UIViewController/*.{h,m}'
      sss.dependency  'MTCategoryComponent/UIKit/UIColor'
      sss.dependency 'MBProgressHUD'
      sss.dependency 'Toast'
    end
    
    ss.subspec 'UIResponder' do |sss|
      sss.source_files = 'MTCategoryComponent/Classes/UIKit/UIResponder/*.{h,m}'
    end
    
    ss.subspec 'UIWindow' do |sss|
      sss.source_files = 'MTCategoryComponent/Classes/UIKit/UIWindow/*.{h,m}'
    end
    
    ss.subspec 'UIBarButtonItem' do |sss|
      sss.source_files = 'MTCategoryComponent/Classes/UIKit/UIBarButtonItem/*.{h,m}'
    end
    
  end
  
  s.subspec 'MBProgessHUD' do |ss|
    
    ss.source_files = 'MTCategoryComponent/Classes/MBProgessHUD/*.{h,m}'
    ss.dependency  'MTCategoryComponent/UIKit'
    ss.dependency 'Masonry'
  end
  
end
