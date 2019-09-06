#
# Be sure to run `pod lib lint TMMasonryExtends.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TMMasonryExtends'
  s.version          = '1.0'
  s.summary          = 'Masonry 扩展库，可以用它为视图显示和隐藏状态设置不同的约束。'

  s.description      = "TMMasonryExtends 是一个 Masonry 扩展库，可以用它为视图显示和隐藏状态设置不同的约束。封装这个库主要是为了解决视图显示、隐藏的时候引入的大量条件判断和约束变更的代码。"

  s.homepage         = 'https://github.com/Tovema-iOS/TMMasonryExtends'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'lxb_0605@qq.com' => 'lxb_0605@qq.com' }
  s.source           = { :git => 'https://github.com/Tovema-iOS/TMMasonryExtends.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'TMMasonryExtends/Classes/**/*'
  
  s.dependency 'Masonry', '~> 1.1'
end
