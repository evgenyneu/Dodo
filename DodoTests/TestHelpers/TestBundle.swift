import UIKit

class TestBundle {
  class func image(named: String) -> UIImage? {
    let bundle = NSBundle(forClass: self)
    
    return UIImage(named: named,
      inBundle: bundle, compatibleWithTraitCollection: nil)
  }
}