import UIKit
import XCTest

class DodoTests: XCTestCase {
  
  var obj: Dodo!
  var superview: UIView!
  var animationShowCompleted = false
  var animationHideCompleted = false
  
  var animationShowDuration: TimeInterval? = nil
  var animationHideDuration: TimeInterval? = nil
  
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
    DodoPresets.success.style.bar.cornerRadius = 16
    obj.style.parent = DodoPresets.success.style
    obj.style.bar.cornerRadius = 17
    
    obj.show("Hello world!")
    
    let toolbar = sabToolbar(superview)!
    XCTAssertEqual(17, toolbar.layer.cornerRadius)
  }
  
  // MARK: - Preset
  
  func testUseThePrest() {
    DodoPresets.success.style.bar.cornerRadius = 16
    
    obj.preset = .success
    obj.show("Hello world!")
    
    let toolbar = sabToolbar(superview)!
    XCTAssertEqual(16, toolbar.layer.cornerRadius)
  }
  
  func testChangeThePrest() {
    DodoPresets.success.style.bar.cornerRadius = 16
    DodoPresets.error.style.bar.cornerRadius = 19
    
    obj.preset = .error
    obj.show("Hello world!")
    
    let toolbar = sabToolbar(superview)!
    XCTAssertEqual(19, toolbar.layer.cornerRadius)
  }
  
  // MARK: - Hiding the bar after delay
  
  func testHideBarAfterDelay() {
    obj.style.bar.hideAfterDelaySeconds = 0.3
    obj.show("Hello world!")
    let expectation = self.expectation(withDescription: "the timer has finished")
    
    MoaTimer.runAfter(0.5) { timer in
      expectation.fulfill()
    }
    
    waitForExpectations(withTimeout: 1) { error in }
    
    let toolbar = sabToolbar(superview)
    
    XCTAssert(toolbar == nil)
    XCTAssert(animationHideCompleted)
  }
  
  func testDoesNotHideBarAfterDelayWhenValueIsZero() {
    obj.style.bar.hideAfterDelaySeconds = 0
    obj.show("Hello world!")
    let expectation = self.expectation(withDescription: "the timer has finished")
    
    MoaTimer.runAfter(0.5) { timer in
      expectation.fulfill()
    }
    
    waitForExpectations(withTimeout: 1) { error in }
    
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
  
  // MARK: - Run closure the the bar is tapped
  
  func testOnTap() {
    obj.style.bar.hideOnTap = false
    var tapClosureCalledTimes = 0
    
    obj.style.bar.onTap = {
      tapClosureCalledTimes += 1
    }
    
    obj.show("Hello world!")
    
    obj.onTap?.didTap(UITapGestureRecognizer())
    XCTAssertEqual(1, tapClosureCalledTimes)
    
    obj.onTap?.didTap(UITapGestureRecognizer())
    XCTAssertEqual(2, tapClosureCalledTimes)
    
    // Keep the bar on screen
    let toolbar = self.sabToolbar(self.superview)
    XCTAssert(toolbar != nil)
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
  
  // MARK: - Keyboard evasion
  
  func testShowBarAboveKeyboard_keyboardAppeasAfterBarIsShown() {
    superview.frame = CGRect(origin: CGPoint(), size: CGSize(width: 230, height: 380))
    obj.style.bar.locationTop = false
    obj.show("Hello world!")
    
    postKeyboardWillShowNotification(CGSize(width: 46, height: 135))
    
    superview.layoutIfNeeded()
    let toolbar = sabToolbar(superview)!
    XCTAssertEqual(380 - toolbar.frame.height - 135 - 10, toolbar.frame.origin.y)
  }
  
  func testShowBarAboveKeyboard_keyboardAppeasBeforeBarIsShown() {
    postKeyboardWillShowNotification(CGSize(width: 46, height: 135))
    
    superview.frame = CGRect(origin: CGPoint(), size: CGSize(width: 230, height: 380))
    obj.style.bar.locationTop = false
    obj.show("Hello world!")
    
    superview.layoutIfNeeded()
    
    let toolbar = sabToolbar(superview)!
    XCTAssertEqual(380 - toolbar.frame.height - 135 - 10, toolbar.frame.origin.y)
  }
  
  func testShowBarAboveKeyboard_keyboardAppeasAfterBarIsShown_withLayoutGuide() {
    let layoutGuide = LayoutGuideMock()
    layoutGuide.frame = CGRect(origin: CGPoint(x: 0, y: 150), size: CGSize(width: 10, height: 14))
    superview.addSubview(layoutGuide)
    
    obj.bottomLayoutGuide = layoutGuide
    superview.frame = CGRect(origin: CGPoint(), size: CGSize(width: 230, height: 380))
    obj.style.bar.locationTop = false
    obj.show("Hello world!")
    
    postKeyboardWillShowNotification(CGSize(width: 46, height: 135))
    
    superview.layoutIfNeeded()
    let toolbar = sabToolbar(superview)!
    let expectY = TestHelpers.round10(150 - Double(toolbar.frame.height) - 135 - 10)
    
    XCTAssertEqual(expectY, TestHelpers.round10(Double(toolbar.frame.origin.y)))
  }
}
