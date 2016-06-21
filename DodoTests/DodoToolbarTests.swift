import UIKit
import XCTest

class DodoToolbarTests: XCTestCase {
  var obj: DodoToolbar!
  var superview: UIView!
  var animationShowCompleted = false
  var animationHideCompleted = false
  var buttonDelegate: ButtonViewDelegateMock!
  
  override func setUp() {
    super.setUp()
    
    buttonDelegate = ButtonViewDelegateMock()
    DodoPresets.resetAll()
    obj = DodoToolbar()
    obj.buttonViewDelegate = buttonDelegate
    superview = UIView()
    
    // Mock animation
    
    animationShowCompleted = false
    animationHideCompleted = false
    
    obj.style.bar.animationShow = { view, duration, locationTop, onComplete in
      onComplete()
      self.animationShowCompleted = true
    }
    
    obj.style.bar.animationHide = { view, duration, locationTop, onComplete in
      onComplete()
      self.animationHideCompleted = true
    }
    
    DodoStyle.resetDefaultStyles()
  }
  
  // MARK: - Show
  
  func testShow() {
    obj.show(inSuperview: superview, withMessage: "hello")
    
    let view = superview.subviews[0] as? DodoToolbar
    XCTAssert(view != nil)
    XCTAssert(animationShowCompleted)
  }
  
  // MARK: - Hide

  func testHide() {
    superview.addSubview(obj)
    
    var completeHandlerCalled = false
    
    obj.hide({
      completeHandlerCalled = true
    })
    
    XCTAssert(superview.subviews.isEmpty)
    XCTAssert(animationHideCompleted)
    XCTAssert(completeHandlerCalled)
  }
  
  func testHideAnimationIsDoneOnceWhenHideIsCalledTwice() {
    superview.addSubview(obj)
    
    var completeHandlerCalled = false
    
    obj.hide({
      completeHandlerCalled = true
    })
    
    animationHideCompleted = false
    completeHandlerCalled = false
    
    obj.hide({
      completeHandlerCalled = true
    })
    
    XCTAssert(superview.subviews.isEmpty)
    XCTAssertFalse(animationHideCompleted)
    XCTAssertFalse(completeHandlerCalled)
  }
  
  // MARK: - Show message
  
  func testUpdateMessage() {
    obj.show(inSuperview: superview, withMessage: "Hello World!")
    
    let labels = sabToolbar(superview)!.subviews.filter { $0 is UILabel }.map { $0 as! UILabel }
    let label = labels[0]

    XCTAssertEqual("Hello World!", label.text!)
  }

  
  // MARK: - Styling the bar
  
  func testUseDefaultStyle() {
    DodoBarDefaultStyles.cornerRadius = 13
    obj.show(inSuperview: superview, withMessage: "Hello World!")
    
    let toolbar = sabToolbar(superview)!
    XCTAssertEqual(13, toolbar.layer.cornerRadius)
  }
  
  func testUsePresetStyle() {
    DodoBarDefaultStyles.cornerRadius = 13
    DodoPresets.success.style.bar.cornerRadius = 16
    obj.style.parent = DodoPresets.success.style
    obj.show(inSuperview: superview, withMessage: "Hello World!")
    
    let toolbar = sabToolbar(superview)!
    XCTAssertEqual(16, toolbar.layer.cornerRadius)
  }
  
  func testSetItemStyle() {
    DodoBarDefaultStyles.cornerRadius = 13
    DodoPresets.success.style.bar.cornerRadius = 16
    obj.style.parent = DodoPresets.success.style
    obj.style.bar.cornerRadius = 17
    obj.show(inSuperview: superview, withMessage: "Hello World!")
    
    let toolbar = sabToolbar(superview)!
    XCTAssertEqual(17, toolbar.layer.cornerRadius)
  }
  
  // MARK: - Create buttons
  
  func testCreateLeftButton() {
    let image = TestBundle.image("67px.png")!
    obj.style.leftButton.image = image
    obj.style.rightButton.image = nil
    
    obj.show(inSuperview: superview, withMessage: "hello")
    
    let buttons = sabButtons(superview)
    
    XCTAssertEqual(2, buttons.count)
    XCTAssertEqual(67, buttons[0].image!.size.width)
    XCTAssert(buttons[1].image == nil)
  }
  
  func testCreateRightButton() {
    let image = TestBundle.image("96px.png")!
    obj.style.leftButton.image = nil
    obj.style.rightButton.image = image
    
    obj.show(inSuperview: superview, withMessage: "hello")
    
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
    
    obj.show(inSuperview: superview, withMessage: "hello")
    
    let buttons = sabButtons(superview)
    
    XCTAssertEqual(2, buttons.count)
    XCTAssertEqual(67, buttons[0].image!.size.width)
    XCTAssertEqual(96, buttons[1].image!.size.width)
  }
  
  func testCreateLeftButtonWithIcon() {
    obj.style.leftButton.icon = DodoIcons.Close
    obj.style.rightButton.image = nil
    
    obj.show(inSuperview: superview, withMessage: "hello")
    
    let buttons = sabButtons(superview)
    
    XCTAssertEqual(2, buttons.count)
    XCTAssertEqual(256, buttons[0].image!.size.width)
  }
  
  func testRunTapCallbackClosures() {
    var tappedLeftButton = false
    obj.style.leftButton.icon = DodoIcons.Close
    obj.style.leftButton.onTap = { tappedLeftButton = true }
    
    var tappedRightButton = false
    obj.style.rightButton.onTap = { tappedRightButton = true }
    
    obj.show(inSuperview: superview, withMessage: "hello")
    
    let buttons = sabButtons(superview)
    
    buttons[0].onTap?.didTap(UITapGestureRecognizer())
    buttons[1].onTap?.didTap(UITapGestureRecognizer())

    XCTAssert(tappedLeftButton)
    XCTAssert(tappedRightButton)
  }
  
  func testCreateNoButtonsWhenImagesAreNotSupplied() {
    obj.style.leftButton.image = nil
    obj.style.rightButton.image = nil
    
    obj.show(inSuperview: superview, withMessage: "hello")
    
    let buttons = sabButtons(superview)
    XCTAssert(buttons.isEmpty)
  }
  
  // MARK: - Use button with a bundled icon
  
  func testUseBundledIcon() {
    obj.style.leftButton.icon = DodoIcons.Close
    
    obj.show(inSuperview: superview, withMessage: "hello")
    
    let buttons = sabButtons(superview)
    
    XCTAssertEqual(2, buttons.count)
    XCTAssertEqual(256, buttons[0].image!.size.width)
    XCTAssert(buttons[1].image == nil)
  }
}
