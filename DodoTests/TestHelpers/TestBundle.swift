import UIKit

class TestBundle {
  class func image(_ named: String) -> UIImage? {
    let bundle = Bundle(for: self)
    
    return UIImage(named: named,
      in: bundle, compatibleWith: nil)
  }
}
