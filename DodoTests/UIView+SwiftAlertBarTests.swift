import UIKit
import XCTest

class UIImageViewDodoExtensionTests: XCTestCase {
  func testGetCreatesAndStoresMoaInstance() {
    let view = UIView()
    let dodo1 = view.dodo
    let dodo2 = view.dodo
    
    XCTAssert(dodo1 === dodo2)
  }
}