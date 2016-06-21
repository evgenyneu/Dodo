import UIKit
import XCTest

extension XCTestCase {
  func sabToolbar(_ superview: UIView) -> DodoToolbar? {
    if superview.subviews.count == 0 { return nil }
    
    let toolbars = superview.subviews.filter { $0 is DodoToolbar }.map { $0 as! DodoToolbar }
    
    guard let toolbar = toolbars.first else {
      return nil
    }
    
    return toolbar
  }
  
  func sabLabel(_ superview: UIView) -> UILabel? {
    return sabToolbar(superview)?.subviews.filter { $0 is UILabel }.map { $0 as! UILabel }.first
  }
  
  func sabButtons(_ superview: UIView) -> [DodoButtonView] {
    if let toolbar = sabToolbar(superview) {
      return toolbar.subviews.filter { $0 is DodoButtonView }.map { $0 as! DodoButtonView }
    }
    
    return []
  }
}
