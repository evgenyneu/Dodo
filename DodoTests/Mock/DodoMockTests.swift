import UIKit
import XCTest

class DodoMockTests: XCTestCase {
  var dodoMock: DodoMock!
  var superview: UIView!
  
  override func setUp() {
    super.setUp()
    
    superview = UIView()
    dodoMock = DodoMock()
    superview.dodo = dodoMock
  }
  
  func testSuccess() {
    dodoMock.success("🌅")
    
    XCTAssertEqual(1, dodoMock.results.total)
    XCTAssertEqual(1, dodoMock.results.success.count)
    XCTAssertEqual(0, dodoMock.results.info.count)
    XCTAssertEqual(0, dodoMock.results.warning.count)
    XCTAssertEqual(0, dodoMock.results.errors.count)

    XCTAssertEqual("🌅", dodoMock.results.success[0])
    
    dodoMock.success("🌞")
    
    XCTAssertEqual(2, dodoMock.results.total)
    XCTAssertEqual(2, dodoMock.results.success.count)

    XCTAssertEqual("🌅", dodoMock.results.success[0])
    XCTAssertEqual("🌞", dodoMock.results.success[1])
  }
  
  func testInfo() {
    dodoMock.info("📊")
    
    XCTAssertEqual(1, dodoMock.results.total)
    XCTAssertEqual(0, dodoMock.results.success.count)
    XCTAssertEqual(1, dodoMock.results.info.count)
    XCTAssertEqual(0, dodoMock.results.warning.count)
    XCTAssertEqual(0, dodoMock.results.errors.count)

    XCTAssertEqual("📊", dodoMock.results.info[0])
    
    dodoMock.info("📝")
    
    XCTAssertEqual(2, dodoMock.results.total)
    XCTAssertEqual(2, dodoMock.results.info.count)
    XCTAssertEqual("📊", dodoMock.results.info[0])
    XCTAssertEqual("📝", dodoMock.results.info[1])
  }
  
  func testWarning() {
    dodoMock.warning("📊")
    
    XCTAssertEqual(1, dodoMock.results.total)
    XCTAssertEqual(0, dodoMock.results.success.count)
    XCTAssertEqual(0, dodoMock.results.info.count)
    XCTAssertEqual(1, dodoMock.results.warning.count)
    XCTAssertEqual(0, dodoMock.results.errors.count)
    
    XCTAssertEqual("📊", dodoMock.results.warning[0])
    
    dodoMock.warning("📝")
    
    XCTAssertEqual(2, dodoMock.results.total)
    XCTAssertEqual(2, dodoMock.results.warning.count)
    XCTAssertEqual("📊", dodoMock.results.warning[0])
    XCTAssertEqual("📝", dodoMock.results.warning[1])
  }
  
  func testError() {
    dodoMock.error("📛")

    XCTAssertEqual(1, dodoMock.results.total)
    XCTAssertEqual(0, dodoMock.results.success.count)
    XCTAssertEqual(0, dodoMock.results.info.count)
    XCTAssertEqual(0, dodoMock.results.warning.count)
    XCTAssertEqual(1, dodoMock.results.errors.count)
    
    XCTAssertEqual("📛", dodoMock.results.errors[0])
    
    dodoMock.error("🚷")
    
    XCTAssertEqual(2, dodoMock.results.total)
    XCTAssertEqual(2, dodoMock.results.errors.count)
    XCTAssertEqual("📛", dodoMock.results.errors[0])
    XCTAssertEqual("🚷", dodoMock.results.errors[1])
  }
}