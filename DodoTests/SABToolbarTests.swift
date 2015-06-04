import UIKit
import XCTest

class SABToolbarTests: XCTestCase {
  var obj: SABToolbar!
  var superview: UIView!
  var animator: MockedAnimator!
  
  override func setUp() {
    super.setUp()
    
    SABPresets.resetAll()
    obj = SABToolbar()
    superview = UIView()
    
    // Use mocked animator    
    animator = MockedAnimator()
    SABStyle.resetDefaultStyles()
  }
  
  // MARK: - Show
  
  func testShow() {
    obj.show(inSuperview: superview, withMessage: "hello", withAnimator: animator)
    
    let view = superview.subviews[0] as? SABToolbar
    XCTAssert(view != nil)
    XCTAssert(animator.animated)
  }
  
  // MARK: - Hide

  func testHide() {
    superview.addSubview(obj)
    
    var completeHandlerCalled = false
    
    obj.hide(animator, onAnimationCompleted: {
      completeHandlerCalled = true
    })
    
    XCTAssert(superview.subviews.isEmpty)
    XCTAssert(animator.animated)
    XCTAssert(completeHandlerCalled)
  }
  
  // MARK: - Show message
  
  func testUpdateMessage() {
    obj.show(inSuperview: superview, withMessage: "Hello World!", withAnimator: animator)
    
    let labels = sabToolbar(superview)!.subviews.filter { $0 is UILabel }.map { $0 as! UILabel }
    let label = labels[0]

    XCTAssertEqual("Hello World!", label.text!)
  }

  
  // MARK: - Styling the bar
  
  func testUseDefaultStyle() {
    SABBarDefaultStyles.cornerRadius = 13
    obj.show(inSuperview: superview, withMessage: "Hello World!", withAnimator: animator)
    
    let toolbar = sabToolbar(superview)!
    XCTAssertEqual(13, toolbar.layer.cornerRadius)
  }
  
  func testUsePresetStyle() {
    SABBarDefaultStyles.cornerRadius = 13
    SABPresets.Success.style.bar.cornerRadius = 16
    obj.style.parent = SABPresets.Success.style
    obj.show(inSuperview: superview, withMessage: "Hello World!", withAnimator: animator)
    
    let toolbar = sabToolbar(superview)!
    XCTAssertEqual(16, toolbar.layer.cornerRadius)
  }
  
  func testSetItemStyle() {
    SABBarDefaultStyles.cornerRadius = 13
    SABPresets.Success.style.bar.cornerRadius = 16
    obj.style.parent = SABPresets.Success.style
    obj.style.bar.cornerRadius = 17
    obj.show(inSuperview: superview, withMessage: "Hello World!", withAnimator: animator)
    
    let toolbar = sabToolbar(superview)!
    XCTAssertEqual(17, toolbar.layer.cornerRadius)
  }
  
  // MARK: - Create buttons
  
  func testCreateLeftButton() {
    let image = TestBundle.image("67px.png")!
    obj.style.leftButton.image = image
    obj.style.rightButton.image = nil
    
    obj.show(inSuperview: superview, withMessage: "hello", withAnimator: animator)
    
    let buttons = sabButtons(superview)
    
    XCTAssertEqual(2, buttons.count)
    XCTAssertEqual(67, buttons[0].image!.size.width)
    XCTAssert(buttons[1].image == nil)
  }
  
  func testCreateRightButton() {
    let image = TestBundle.image("96px.png")!
    obj.style.leftButton.image = nil
    obj.style.rightButton.image = image
    
    obj.show(inSuperview: superview, withMessage: "hello", withAnimator: animator)
    
    let buttons = sabButtons(superview)
    
    XCTAssertEqual(2, buttons.count)
    XCTAssert(buttons[0].image == nil)
    XCTAssertEqual(96, buttons[1].image!.size.width)
  }
  
  func testCreateBothRightAndLeftButtons() {
    let imageLeft = TestBundle.image("67px.png")!
    let imageRight = TestBundle.image("96px.png")!
    
    obj.style.leftButton.image = imageLeft
    obj.style.rightButton.image = imageRight
    
    obj.show(inSuperview: superview, withMessage: "hello", withAnimator: animator)
    
    let buttons = sabButtons(superview)
    
    XCTAssertEqual(2, buttons.count)
    XCTAssertEqual(67, buttons[0].image!.size.width)
    XCTAssertEqual(96, buttons[1].image!.size.width)
  }
  
  func testRunTapCallbackClosures() {
    var tappedLeftButton = false
    obj.style.leftButton.onTap = { tappedLeftButton = true }
    
    var tappedRightButton = false
    obj.style.rightButton.onTap = { tappedRightButton = true }
    
    obj.show(inSuperview: superview, withMessage: "hello", withAnimator: animator)
    
    let buttons = sabButtons(superview)
    
    buttons[0].onTap?.didTap(UITapGestureRecognizer())
    buttons[1].onTap?.didTap(UITapGestureRecognizer())

    XCTAssert(tappedLeftButton)
    XCTAssert(tappedRightButton)
  }
}
