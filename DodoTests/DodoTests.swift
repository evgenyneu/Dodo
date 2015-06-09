import UIKit
import XCTest

class DodoTests: XCTestCase {
  
  var obj: Dodo!
  var superview: UIView!
  var animationShowCompleted = false
  var animationHideCompleted = false
  
  var animationShowDuration: NSTimeInterval? = nil
  var animationHideDuration: NSTimeInterval? = nil
  
  var animationShowTop: Bool? = nil
  var animationHideTop: Bool? = nil

  override func setUp() {
    super.setUp()
    
    DodoPresets.resetAll()
    superview = UIView()
    obj = Dodo(superview: superview)

    // Mock animation
    
    animationShowCompleted = false
    animationHideCompleted = false
    
    obj.style.bar.animationShow = { view, duration, locationTop, onComplete in
      onComplete()
      self.animationShowDuration = duration
      self.animationShowTop = locationTop
      self.animationShowCompleted = true
    }
    
    obj.style.bar.animationHide = { view, duration, locationTop, onComplete in
      onComplete()
      self.animationHideDuration = duration
      self.animationHideTop = locationTop
      self.animationHideCompleted = true
    }
    
    DodoStyle.resetDefaultStyles()
  }
  
  // MARK: - Show
  
  func testShow() {
    obj.show("Hello world!")
    let label = sabLabel(superview)
    XCTAssertEqual("Hello world!", label!.text!)
    XCTAssert(animationShowCompleted)
  }
  
  func testShow_removeExsitingBar() {
    superview.addSubview(DodoToolbar())
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
    XCTAssert(animationHideCompleted)
  }
  
  // MARK: - Show shortcut methods
  
  func testSuccess() {
    obj.success("Hello world!")
    let bar = sabToolbar(superview)
    XCTAssertEqual(DodoColor.fromHexString("#00CC03C9"), bar!.backgroundColor!)
  }
  
  func testInfo() {
    obj.info("Hello world!")
    let bar = sabToolbar(superview)
    XCTAssertEqual(DodoColor.fromHexString("#0057FF96"), bar!.backgroundColor!)
  }
  
  func testWarning() {
    obj.warning("Hello world!")
    let bar = sabToolbar(superview)
    XCTAssertEqual(DodoColor.fromHexString("#CEC411DD"), bar!.backgroundColor!)
  }
  
  func testError() {
    obj.error("Hello world!")
    let bar = sabToolbar(superview)
    XCTAssertEqual(DodoColor.fromHexString("#FF0B0BCC"), bar!.backgroundColor!)
  }
  
  // MARK: - Style
  
  func testUseDefaultStyle() {
    DodoBarDefaultStyles.cornerRadius = 13
    obj.show("Hello world!")
    
    let toolbar = sabToolbar(superview)!
    XCTAssertEqual(13, toolbar.layer.cornerRadius)
  }
  
  func testSetItemStyle() {
    DodoBarDefaultStyles.cornerRadius = 13
    DodoPresets.Success.style.bar.cornerRadius = 16
    obj.style.parent = DodoPresets.Success.style
    obj.style.bar.cornerRadius = 17
    
    obj.show("Hello world!")
    
    let toolbar = sabToolbar(superview)!
    XCTAssertEqual(17, toolbar.layer.cornerRadius)
  }
  
  // MARK: - Preset
  
  func testUseThePrest() {
    DodoPresets.Success.style.bar.cornerRadius = 16
    
    obj.preset = .Success
    obj.show("Hello world!")
    
    let toolbar = sabToolbar(superview)!
    XCTAssertEqual(16, toolbar.layer.cornerRadius)
  }
  
  func testChangeThePrest() {
    DodoPresets.Success.style.bar.cornerRadius = 16
    DodoPresets.Error.style.bar.cornerRadius = 19
    
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
    XCTAssert(animationHideCompleted)
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
    XCTAssertFalse(animationHideCompleted)
  }
  
  // MARK: - Hiding when button is tapped
  
  func testHideWhenButtonIsTapped() {
    obj.style.leftButton.icon = DodoIcons.Close
    obj.style.leftButton.hideOnTap = true
    
    obj.show("Hello world!")
    
    // Tap left button
    let leftButton = sabButtons(superview)[0]
    leftButton.onTap?.didTap(UITapGestureRecognizer())
    
    // Ensure bar is hidden
    let toolbar = sabToolbar(superview)
    XCTAssert(toolbar == nil)
    XCTAssert(animationHideCompleted)
  }
  
  func testDoNotHideWhenButtonIsTapped() {
    obj.style.leftButton.icon = DodoIcons.Close
    obj.style.leftButton.hideOnTap = false
    
    obj.show("Hello world!")
    
    // Tap left button
    let leftButton = sabButtons(superview)[0]
    leftButton.onTap?.didTap(UITapGestureRecognizer())
    
    // Ensure bar is hidden
    let toolbar = sabToolbar(superview)
    XCTAssert(toolbar != nil)
  }
  
  // MARK: - Hide when toolbar is tapped
  
  func testHideOnTap() {
    obj.style.bar.hideOnTap = true
    
    obj.show("Hello world!")
    
    obj.onTap?.didTap(UITapGestureRecognizer())
    
    let toolbar = self.sabToolbar(self.superview)
    XCTAssert(toolbar == nil)
    XCTAssert(animationHideCompleted)
  }
  
  // MARK: - Animation
  
  func testShowPassAnimationDuration() {
    obj.style.bar.animationShowDuration = 77
    obj.style.bar.animationHideDuration = 88

    obj.show("Hello world!")
    obj.hide()

    XCTAssertEqual(77, animationShowDuration!)
    XCTAssertEqual(88, animationHideDuration!)
  }
  
  func testPassTopLocationToAnimationCallback() {
    obj.style.bar.locationTop = true
    
    obj.show("Hello world!")
    obj.hide()
    
    XCTAssert(animationShowTop!)
    XCTAssert(animationHideTop!)
  }
  
  func testPassBottomLocationToAnimationCallback() {
    obj.style.bar.locationTop = false
    
    obj.show("Hello world!")
    obj.hide()
    
    XCTAssertFalse(animationShowTop!)
    XCTAssertFalse(animationHideTop!)
  }
}
