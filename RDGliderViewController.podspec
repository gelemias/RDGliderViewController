#
# Be sure to run `pod lib lint RDGliderViewController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RDGliderViewController'
  s.version          = '0.1.68'
  s.summary          = 'Control for a draggable ViewController gliding over another ViewController.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  RDGliderViewController is a view controller that manages a scrollable view using one side as a sliding point,
  choosing between Left-to-Right, Top-to-Bottom, Right-to-Left and Bottom-to-Top,
  and setting an array of offsets as percent values to determine the gliding view steps.
  DESC

  s.homepage         = 'https://github.com/gelemias/RDGliderViewController'
  s.screenshots      = 'https://raw.githubusercontent.com/gelemias/RDGliderViewController/develop/img/1.png',
                       'https://raw.githubusercontent.com/gelemias/RDGliderViewController/develop/img/2.png',
                       'https://raw.githubusercontent.com/gelemias/RDGliderViewController/develop/img/3.png',
                       'https://raw.githubusercontent.com/gelemias/RDGliderViewController/develop/img/4.png'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Guillermo RD' => 'gelemias@gmail.com' }
  s.source           = { :git => 'https://github.com/gelemias/RDGliderViewController.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'RDGliderViewController/**/*'

end
