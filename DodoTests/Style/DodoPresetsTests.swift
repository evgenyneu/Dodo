import UIKit
import XCTest

class DodoPresetsTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
    
    DodoPresets.resetAll()
  }
  
  func testChangeThePresetValue() {
    let style = DodoPresets.Success.style
    style.leftButton.size = CGSize(width: 91, height: 91)
    
    XCTAssertEqual(91, DodoPresets.Success.style.leftButton.size.width)
  }
  
  func testResetAllPresets() {
    let style = DodoPresets.Success.style
    style.leftButton.size = CGSize(width: 91, height: 91)
    
    let errorStyle = DodoPresets.Error.style
    errorStyle.leftButton.size = CGSize(width: 13, height: 13)
    
    DodoPresets.resetAll()
    
    XCTAssertEqual(25, DodoPresets.Success.style.leftButton.size.width)
    XCTAssertEqual(25, DodoPresets.Error.style.leftButton.size.width)
  }
  
  func testResetOnePreset() {
    let successStyle = DodoPresets.Success.style
    successStyle.leftButton.size = CGSize(width: 91, height: 91)
    
    let errorStyle = DodoPresets.Error.style
    errorStyle.leftButton.size = CGSize(width: 13, height: 13)
    
    DodoPresets.Success.reset()
    
    XCTAssertEqual(25, DodoPresets.Success.style.leftButton.size.width)
    XCTAssertEqual(13, DodoPresets.Error.style.leftButton.size.width)
  }
}