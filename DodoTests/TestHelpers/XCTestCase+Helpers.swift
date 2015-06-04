import UIKit
import XCTest

extension XCTestCase {
  func sabToolbar(superview: UIView) -> DodoToolbar? {
    if superview.subviews.count == 0 { return nil }
    return superview.subviews[0] as? DodoToolbar
  }
  
  func sabLabel(superview: UIView) -> UILabel? {
    return sabToolbar(superview)?.subviews.filter { $0 is UILabel }.map { $0 as! UILabel }.first
  }
  
  func sabButtons(superview: UIView) -> [DodoButtonView] {
    if let toolbar = sabToolbar(superview) {
      return toolbar.subviews.filter { $0 is DodoButtonView }.map { $0 as! DodoButtonView }
    }
    
    return []
  }
}