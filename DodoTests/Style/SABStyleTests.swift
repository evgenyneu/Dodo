
import UIKit
import XCTest

class SABStyleTests: XCTestCase {
  
  var superview: UIView!
  var animator: MockedAnimator!
  
  override func setUp() {
    super.setUp()

    superview = UIView()
    
    // Use mocked animator
    animator = MockedAnimator()
    SABStyle.resetDefaultStyles()
  }
  
  func testGetDefaultSetting() {
    SABBarDefaultStyles.cornerRadius = 25

    let style = SABStyle()
    XCTAssertEqual(25, style.bar.cornerRadius)
  }
  
  func testOverideDefaultStyle() {
    SABBarDefaultStyles.cornerRadius = 25
    
    let style = SABStyle()
    style.bar.cornerRadius = 30
    XCTAssertEqual(30, style.bar.cornerRadius)
  }
  
  // MARK: - With parent style
  
  func testWithParent_getDefaultStyle() {
    SABBarDefaultStyles.cornerRadius = 25
    
    let parent = SABStyle()
    let style = SABStyle(parentStyle: parent)

    XCTAssertEqual(25, style.bar.cornerRadius)
  }
  
  func testWithParent_overridenInParent() {
    SABBarDefaultStyles.cornerRadius = 25
    
    let parent = SABStyle()
    parent.bar.cornerRadius = 30
    let style = SABStyle(parentStyle: parent)
    
    XCTAssertEqual(30, style.bar.cornerRadius)
  }
  
  func testWithParent_overrideInObject() {
    SABBarDefaultStyles.cornerRadius = 25
    
    let parent = SABStyle()
    parent.bar.cornerRadius = 30
    let style = SABStyle(parentStyle: parent)
    style.bar.cornerRadius = 40
    
    XCTAssertEqual(40, style.bar.cornerRadius)
  }
  
  // MARK: - Change
  
  func testWithParent_changeParent() {
    let parentOne = SABStyle()
    parentOne.bar.cornerRadius = 100
    parentOne.label.numberOfLines = 99
    parentOne.leftButton.size = CGSize(width: 88, height: 88)
    parentOne.rightButton.size = CGSize(width: 77, height: 77)
    
    // Create a style with one parent
    // -------------------

    let style = SABStyle(parentStyle: parentOne)
    
    XCTAssertEqual(100, style.bar.cornerRadius)
    
    // Now change the parent for the style
    // -------------------
    
    let parentTwo = SABStyle()
    parentTwo.bar.cornerRadius = 1000
    parentTwo.label.numberOfLines = 999
    parentTwo.leftButton.size = CGSize(width: 888, height: 888)
    parentTwo.rightButton.size = CGSize(width: 777, height: 777)
    style.parent = parentTwo
    
    // It should show the style from the new parent
    // -------------------

    XCTAssertEqual(1000, style.bar.cornerRadius)
    XCTAssertEqual(999, style.label.numberOfLines)
    XCTAssertEqual(888, style.leftButton.size.width)
    XCTAssertEqual(777, style.rightButton.size.width)
  }
  
  // MARK: - Reset default styles
  
  func testResetDefaultStyles() {
    SABBarDefaultStyles.cornerRadius = 213
    SABLabelDefaultStyles.numberOfLines = 31
    SABButtonDefaultStyles.horizontalMarginToBar = 41
    
    SABStyle.resetDefaultStyles()
    
    XCTAssertEqual(20, SABBarDefaultStyles.cornerRadius)
    XCTAssertEqual(3, SABLabelDefaultStyles.numberOfLines)
    XCTAssertEqual(41, SABButtonDefaultStyles.horizontalMarginToBar)
  }
  
  // MARK: - Clear
  
  func testClear() {
    SABBarDefaultStyles.cornerRadius = 3
    SABLabelDefaultStyles.numberOfLines = 4
    SABButtonDefaultStyles.horizontalMarginToBar = 5
    
    // Parent styles
    // ------------------
    
    let parent = SABStyle()
    parent.bar.cornerRadius = 30
    parent.label.numberOfLines = 40
    parent.leftButton.horizontalMarginToBar = 50
    parent.rightButton.horizontalMarginToBar = 51

    // Object styles
    // ------------------
    
    let style = SABStyle(parentStyle: parent)
    style.bar.cornerRadius = 300
    style.label.numberOfLines = 400
    style.leftButton.horizontalMarginToBar = 500
    style.rightButton.horizontalMarginToBar = 510
    
    // Check object styles
    // ------------------
    
    XCTAssertEqual(300, style.bar.cornerRadius)
    XCTAssertEqual(400, style.label.numberOfLines)
    XCTAssertEqual(500, style.leftButton.horizontalMarginToBar)
    XCTAssertEqual(510, style.rightButton.horizontalMarginToBar)
    
    // Clear the object styles
    // ------------------
    
    style.clear()
    
    XCTAssertEqual(30, style.bar.cornerRadius)
    XCTAssertEqual(40, style.label.numberOfLines)
    XCTAssertEqual(50, style.leftButton.horizontalMarginToBar)
    XCTAssertEqual(51, style.rightButton.horizontalMarginToBar)

    // Clear the parent styles
    // ------------------
    
    parent.clear()
    
    XCTAssertEqual(3, style.bar.cornerRadius)
    XCTAssertEqual(4, style.label.numberOfLines)
    XCTAssertEqual(5, style.leftButton.horizontalMarginToBar)
    XCTAssertEqual(5, style.rightButton.horizontalMarginToBar)
  }
}