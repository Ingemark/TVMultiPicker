Pod::Spec.new do |s|
  s.name             = 'TVMultiPicker'
  s.version          = '0.0.4'
  s.summary          = 'Generic view with arbitrary number of horizontal pickers.'

  s.description      = <<-DESC
Simple generic viewcontroller with arbitrary number of horizontal pickers.
Contains pre-configured date picker. Supports user defined style configuration.
                       DESC

  s.homepage         = 'https://github.com/Ingemark/TVMultiPicker.git'

  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Filip Dujmusic' => 'filip.dujmusic@ingemark.com' }
  s.source           = { :git => 'https://github.com/Ingemark/TVMultiPicker.git', :tag => s.version.to_s }

  s.platform     = :tvos, "9.0"
  
  s.source_files = 'TVMultiPicker/*'
end
