import UIKit
import XCTest

extension XCTestCase {
  func sabToolbar(superview: UIView) -> SABToolbar? {
    if superview.subviews.count == 0 { return nil }
    return superview.subviews[0] as? SABToolbar
  }
  
  func sabLabel(superview: UIView) -> UILabel? {
    return sabToolbar(superview)?.subviews.filter { $0 is UILabel }.map { $0 as! UILabel }.first
  }
  
  func sabButtons(superview: UIView) -> [SABButtonView] {
    if let toolbar = sabToolbar(superview) {
      return toolbar.subviews.filter { $0 is SABButtonView }.map { $0 as! SABButtonView }
    }
    
    return []
  }
}