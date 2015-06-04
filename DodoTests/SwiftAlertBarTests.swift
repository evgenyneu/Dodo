import UIKit
import XCTest

class SwiftAlertBarTests: XCTestCase {
  
  var obj: SwiftAlertBar!
  var superview: UIView!
  var animatorShow: MockedAnimator!
  var animatorHide: MockedAnimator!

  override func setUp() {
    super.setUp()
    
    SABPresets.resetAll()
    superview = UIView()
    obj = SwiftAlertBar(superview: superview)
    
    SABStyle.resetDefaultStyles()
    
    // Use mocked animator
    // ------------
    
    animatorShow = MockedAnimator()
    animatorHide = MockedAnimator()
    
    obj.animatorShow = animatorShow
    obj.animatorHide = animatorHide
  }
  
  // MARK: - Show
  
  func testShow() {
    obj.show("Hello world!")
    let label = sabLabel(superview)
    XCTAssertEqual("Hello world!", label!.text!)
    XCTAssert(animatorShow.animated)
  }
  
  func testShow_removeExsitingBar() {
    superview.addSubview(SABToolbar())
    obj.show("Hello world!")
    
    XCTAssertEqual(1, superview.subviews.count)
    let label = sabLabel(superview)
    XCTAssertEqual("Hello world!", label!.text!)
  }
  
  // MARK: - Hide
  
  func testHide() {
    obj.show("Hello world!")
    obj.hide()
    
    let toolbar = self.sabToolbar(self.superview)
    XCTAssert(toolbar == nil)
    XCTAssert(animatorHide.animated)
  }
  
  // MARK: - Show shortcut methods
  
  func testSuccess() {
    obj.success("Hello world!")
    let bar = sabToolbar(superview)
    XCTAssertEqual(TegUIColor.fromHexString("#00CC03C9"), bar!.backgroundColor!)
  }
  
  func testInfo() {
    obj.info("Hello world!")
    let bar = sabToolbar(superview)
    XCTAssertEqual(TegUIColor.fromHexString("#0057FF96"), bar!.backgroundColor!)
  }
  
  func testWarning() {
    obj.warning("Hello world!")
    let bar = sabToolbar(superview)
    XCTAssertEqual(TegUIColor.fromHexString("#CEC411DD"), bar!.backgroundColor!)
  }
  
  func testError() {
    obj.error("Hello world!")
    let bar = sabToolbar(superview)
    XCTAssertEqual(TegUIColor.fromHexString("#FF0B0BCC"), bar!.backgroundColor!)
  }
  
  // MARK: - Style
  
  func testUseDefaultStyle() {
    SABBarDefaultStyles.cornerRadius = 13
    obj.show("Hello world!")
    
    let toolbar = sabToolbar(superview)!
    XCTAssertEqual(13, toolbar.layer.cornerRadius)
  }
  
  func testSetItemStyle() {
    SABBarDefaultStyles.cornerRadius = 13
    SABPresets.Success.style.bar.cornerRadius = 16
    obj.style.parent = SABPresets.Success.style
    obj.style.bar.cornerRadius = 17
    
    obj.show("Hello world!")
    
    let toolbar = sabToolbar(superview)!
    XCTAssertEqual(17, toolbar.layer.cornerRadius)
  }
  
  // MARK: - Preset
  
  func testUseThePrest() {
    SABPresets.Success.style.bar.cornerRadius = 16
    
    obj.preset = .Success
    obj.show("Hello world!")
    
    let toolbar = sabToolbar(superview)!
    XCTAssertEqual(16, toolbar.layer.cornerRadius)
  }
  
  func testChangeThePrest() {
    SABPresets.Success.style.bar.cornerRadius = 16
    SABPresets.Error.style.bar.cornerRadius = 19
    
    obj.preset = .Error
    obj.show("Hello world!")
    
    let toolbar = sabToolbar(superview)!
    XCTAssertEqual(19, toolbar.layer.cornerRadius)
  }
  
  // MARK: - Hiding the bar after delay
  
  func testHideBarAfterDelay() {
    obj.style.bar.hideAfterDelaySeconds = 0.3
    obj.show("Hello world!")
    let expectation = expectationWithDescription("the timer has finished")
    
    MoaTimer.runAfter(0.5) { timer in
      expectation.fulfill()
    }
    
    waitForExpectationsWithTimeout(1) { error in }
    
    let toolbar = sabToolbar(superview)
    
    XCTAssert(toolbar == nil)
    XCTAssert(animatorHide.animated)
  }
  
  func testDoesNotHideBarAfterDelayWhenValueIsZero() {
    obj.style.bar.hideAfterDelaySeconds = 0
    obj.show("Hello world!")
    let expectation = expectationWithDescription("the timer has finished")
    
    MoaTimer.runAfter(0.5) { timer in
      expectation.fulfill()
    }
    
    waitForExpectationsWithTimeout(1) { error in }
    
    let toolbar = sabToolbar(superview)
    
    XCTAssert(toolbar != nil)
    XCTAssertFalse(animatorHide.animated)
  }
  
  // MARK: - Hide on tap
  
  func testHideOnTap() {
    obj.style.bar.hideOnTap = true
    
    obj.show("Hello world!")
    
    obj.onTap?.didTap(UITapGestureRecognizer())
    
    let toolbar = self.sabToolbar(self.superview)
    XCTAssert(toolbar == nil)
    XCTAssert(animatorHide.animated)
  }
}
