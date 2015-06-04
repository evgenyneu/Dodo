import UIKit
import XCTest

class SABPresetsTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
    
    SABPresets.resetAll()
  }
  
  func testChangeThePresetValue() {
    let style = SABPresets.Success.style
    style.leftButton.size = CGSize(width: 91, height: 91)
    
    XCTAssertEqual(91, SABPresets.Success.style.leftButton.size.width)
  }
  
  func testResetAllPresets() {
    let style = SABPresets.Success.style
    style.leftButton.size = CGSize(width: 91, height: 91)
    
    let errorStyle = SABPresets.Error.style
    errorStyle.leftButton.size = CGSize(width: 13, height: 13)
    
    SABPresets.resetAll()
    
    XCTAssertEqual(25, SABPresets.Success.style.leftButton.size.width)
    XCTAssertEqual(25, SABPresets.Error.style.leftButton.size.width)
  }
  
  func testResetOnePreset() {
    let successStyle = SABPresets.Success.style
    successStyle.leftButton.size = CGSize(width: 91, height: 91)
    
    let errorStyle = SABPresets.Error.style
    errorStyle.leftButton.size = CGSize(width: 13, height: 13)
    
    SABPresets.Success.reset()
    
    XCTAssertEqual(25, SABPresets.Success.style.leftButton.size.width)
    XCTAssertEqual(13, SABPresets.Error.style.leftButton.size.width)
  }
}