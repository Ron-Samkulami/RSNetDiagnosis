#
# Be sure to run `pod lib lint RSNetDiagnosis.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RSNetDiagnosis'
  s.version          = '0.1.0'
  s.summary          = 'Net diagnosis tool on iOS.'

  s.description      = <<-DESC
Tool for net diagnosis on iOS platform.
                       DESC

  s.homepage         = 'https://github.com/Ron-Samkulami/RSNetDiagnosis'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Ron-Samkulami' => 'huangxiongrong@37.com' }
  s.source           = { :git => 'https://github.com/Ron-Samkulami/RSNetDiagnosis.git', :tag => s.version.to_s }

  s.ios.deployment_target = '12.0'

  s.source_files = 'RSNetDiagnosis/Classes/**/*'
 
# #  Install with Framework must add -lc++ in Other Linker Flags
# s.user_target_xcconfig = {
#     'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64',
#     'OTHER_LDFLAGS' => '-lc++',
# }
#
# s.source_files = 'RSNetDiagnosis/Library/*.framework/Headers/*'
# s.public_header_files = 'RSNetDiagnosis/Library/*.framework/Headers/*'
# s.ios.vendored_frameworks = 'RSNetDiagnosis/Library/*.framework'
#

  
end
