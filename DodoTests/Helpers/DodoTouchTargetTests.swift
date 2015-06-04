import UIKit
import XCTest

class DodoTouchTargetTests: XCTestCase {
  func testIncreaseTheBounds() {
    let bounds = CGRect(
      origin: CGPoint(),
      size: CGSize(width: 30, height: 40)
    )
    
    let result = DodoTouchTarget.optimize(bounds)
    
    XCTAssertEqual(result.width, 44)
    XCTAssertEqual(result.height, 44)
    XCTAssertEqual(result.origin.x, -7)
    XCTAssertEqual(result.origin.y, -2)
  }
  
  func testKeepTheBoundsBEcauseTheyAreBigEnought() {
    let bounds = CGRect(
      origin: CGPoint(),
      size: CGSize(width: 50, height: 60)
    )
    
    let result = DodoTouchTarget.optimize(bounds)
    
    XCTAssertEqual(result.width, 50)
    XCTAssertEqual(result.height, 60)
    XCTAssertEqual(result.origin.x, 0)
    XCTAssertEqual(result.origin.y, 0)
  }
}