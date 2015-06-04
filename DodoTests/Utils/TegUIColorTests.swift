import UIKit
import XCTest

class TegUIColorTests: XCTestCase {

  // fromHexString
  // -----------------
  
  func testFromHexString_withoutAlpha() {
    let result = TegUIColor.fromHexString("#102030")
    var red: CGFloat = 0
    var green: CGFloat = 0
    var blue: CGFloat = 0
    var alpha: CGFloat = 0

    result.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
    
    XCTAssertEqual(Int(red * 255), 16)
    XCTAssertEqual(Int(green * 255), 32)
    XCTAssertEqual(Int(blue * 255), 48)
    XCTAssertEqual(Int(alpha * 255), 255)
  }
  
  func testFromHexString_withAlpha() {
    let result = TegUIColor.fromHexString("#f1a2b3a6")
    var red: CGFloat = 0
    var green: CGFloat = 0
    var blue: CGFloat = 0
    var alpha: CGFloat = 0
    
    result.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
    
    XCTAssertEqual(Int(red * 255), 241)
    XCTAssertEqual(Int(green * 255), 162)
    XCTAssertEqual(Int(blue * 255), 179)
    XCTAssertEqual(Int(alpha * 255), 166)
  }
  
  func testFromHexString_doesNotStartWithHash() {    
    let result = TegUIColor.fromHexString("f1a2b3a6")
    var red: CGFloat = 0
    var green: CGFloat = 0
    var blue: CGFloat = 0
    var alpha: CGFloat = 0
    
    result.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
    
    XCTAssertEqual(Int(red * 255), 0)
    XCTAssertEqual(Int(green * 255), 0)
    XCTAssertEqual(Int(blue * 255), 0)
    XCTAssertEqual(Int(alpha * 255), 0)
  }
  
  func testFromHexString_doesNotContainHex() {
    let result = TegUIColor.fromHexString("#😵not_a_hex_")
    var red: CGFloat = 0
    var green: CGFloat = 0
    var blue: CGFloat = 0
    var alpha: CGFloat = 0
    
    result.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
    
    XCTAssertEqual(Int(red * 255), 0)
    XCTAssertEqual(Int(green * 255), 0)
    XCTAssertEqual(Int(blue * 255), 0)
    XCTAssertEqual(Int(alpha * 255), 0)
  }
  
  func testFromHexString_incorrectLength() {
    let result = TegUIColor.fromHexString("#12")
    var red: CGFloat = 0
    var green: CGFloat = 0
    var blue: CGFloat = 0
    var alpha: CGFloat = 0
    
    result.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
    
    XCTAssertEqual(Int(red * 255), 0)
    XCTAssertEqual(Int(green * 255), 0)
    XCTAssertEqual(Int(blue * 255), 0)
    XCTAssertEqual(Int(alpha * 255), 0)
  }
}
