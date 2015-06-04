import UIKit
import XCTest

class PixelColorTests: XCTestCase {
  
  func testPixelColor() {
    let image = TestBundle.image("red_and_green")!
    
    var color = PixelColor.colorForPoint(image, point: CGPoint(x: 10, y: 10))
    XCTAssertEqual(UIColor.redColor(), color)
    
    color = PixelColor.colorForPoint(image, point: CGPoint(x: 10, y: 60))
    XCTAssertEqual(UIColor.greenColor(), color)
    
    color = PixelColor.colorForPoint(image, point: CGPoint(x: 60, y: 10))
    XCTAssertEqual(UIColor.greenColor(), color)
    
    color = PixelColor.colorForPoint(image, point: CGPoint(x: 60, y: 60))
    XCTAssertEqual(UIColor.redColor(), color)
  }
}