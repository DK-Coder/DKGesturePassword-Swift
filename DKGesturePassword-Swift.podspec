Pod::Spec.new do |s|

  s.name         = "DKGesturePassword-Swift"
  s.version      = "1.0.1"
  s.summary      = "Swift版的手势密码。支持swift 3.0"

  s.homepage     = "https://github.com/DK-Coder/DKGesturePassword-Swift"

  s.license      = "MIT"

  s.author       = { "DK-Coder" => "kb01020304@qq.com" }

  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/DK-Coder/DKGesturePassword-Swift.git", :tag => "#{s.version}" }

  s.source_files  = "DKGesturePassword-Swift/DKGesturePassword-Swift/*"

  s.resources = "DKGesturePassword-Swift/DKGesturePassword-Swift/Resources/*.png"

  # s.requires_arc = true

end
