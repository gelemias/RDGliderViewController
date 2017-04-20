#
# Be sure to run `pod lib lint RDGliderViewController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RDGliderViewController'
  s.version          = '0.1.0'
  s.summary          = 'Control for a draggable ViewController gliding over another ViewController.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/gelemias/RDGliderViewController'
  s.screenshots      = 'https://github.com/gelemias/RDGliderViewController/tree/develop/img/1.png',
                       'https://github.com/gelemias/RDGliderViewController/tree/develop/img/2.png',
                       'https://github.com/gelemias/RDGliderViewController/tree/develop/img/3.png',
                       'https://github.com/gelemias/RDGliderViewController/tree/develop/img/4.png'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Guillermo RD' => 'gelemias@gmail.com' }
  s.source           = { :git => 'https://github.com/gelemias/RDGliderViewController.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'RDGliderViewController/**/*'

end
