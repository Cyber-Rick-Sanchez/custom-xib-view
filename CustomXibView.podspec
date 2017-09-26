Pod::Spec.new do |spec|
  spec.name = "CustomXibView"
  spec.version = "1.0.0"
  spec.summary = "A simple way to reuse views created in xibs."
  spec.homepage = "https://github.com/Peterek/custom-xib-view"
  spec.license = { type: 'MIT', file: 'LICENSE' }
  spec.authors = { "Piotr Więcaszek" => 'pwiecaszek@example.com' }

  spec.platform = :ios, "9.0"
  spec.requires_arc = true
  spec.source = { git: "https://github.com/Peterek/custom-xib-view.git", tag: spec.version.to_s, submodules: true }
  spec.source_files = "Sources/**/*"

  spec.frameworks = "UIKit"
end