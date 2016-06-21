import UIKit
import XCTest

class DodoPresetsTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
    
    DodoPresets.resetAll()
  }
  
  func testChangeThePresetValue() {
    let style = DodoPresets.success.style
    style.leftButton.size = CGSize(width: 91, height: 91)
    
    XCTAssertEqual(91, DodoPresets.success.style.leftButton.size.width)
  }
  
  func testResetAllPresets() {
    let style = DodoPresets.success.style
    style.leftButton.size = CGSize(width: 91, height: 91)
    
    let errorStyle = DodoPresets.error.style
    errorStyle.leftButton.size = CGSize(width: 13, height: 13)
    
    DodoPresets.resetAll()
    
    XCTAssertEqual(25, DodoPresets.success.style.leftButton.size.width)
    XCTAssertEqual(25, DodoPresets.error.style.leftButton.size.width)
  }
  
  func testResetOnePreset() {
    let successStyle = DodoPresets.success.style
    successStyle.leftButton.size = CGSize(width: 91, height: 91)
    
    let errorStyle = DodoPresets.error.style
    errorStyle.leftButton.size = CGSize(width: 13, height: 13)
    
    DodoPresets.success.reset()
    
    XCTAssertEqual(25, DodoPresets.success.style.leftButton.size.width)
    XCTAssertEqual(13, DodoPresets.error.style.leftButton.size.width)
  }
}
