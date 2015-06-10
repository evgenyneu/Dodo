
import UIKit
import XCTest

class DodoStyleTests: XCTestCase {
  
  var superview: UIView!
  
  override func setUp() {
    super.setUp()

    superview = UIView()

    DodoStyle.resetDefaultStyles()
  }
  
  func testGetDefaultSetting() {
    DodoBarDefaultStyles.cornerRadius = 25

    let style = DodoStyle()
    XCTAssertEqual(25, style.bar.cornerRadius)
  }
  
  func testOverideDefaultStyle() {
    DodoBarDefaultStyles.cornerRadius = 25
    
    let style = DodoStyle()
    style.bar.cornerRadius = 30
    XCTAssertEqual(30, style.bar.cornerRadius)
  }
  
  // MARK: - With parent style
  
  func testWithParent_getDefaultStyle() {
    DodoBarDefaultStyles.cornerRadius = 25
    
    let parent = DodoStyle()
    let style = DodoStyle(parentStyle: parent)

    XCTAssertEqual(25, style.bar.cornerRadius)
  }
  
  func testWithParent_overridenInParent() {
    DodoBarDefaultStyles.cornerRadius = 25
    
    let parent = DodoStyle()
    parent.bar.cornerRadius = 30
    let style = DodoStyle(parentStyle: parent)
    
    XCTAssertEqual(30, style.bar.cornerRadius)
  }
  
  func testWithParent_overrideInObject() {
    DodoBarDefaultStyles.cornerRadius = 25
    
    let parent = DodoStyle()
    parent.bar.cornerRadius = 30
    let style = DodoStyle(parentStyle: parent)
    style.bar.cornerRadius = 40
    
    XCTAssertEqual(40, style.bar.cornerRadius)
  }
  
  // MARK: - Change
  
  func testWithParent_changeParent() {
    let parentOne = DodoStyle()
    parentOne.bar.cornerRadius = 100
    parentOne.label.numberOfLines = 99
    parentOne.leftButton.size = CGSize(width: 88, height: 88)
    parentOne.rightButton.size = CGSize(width: 77, height: 77)
    
    // Create a style with one parent
    // -------------------

    let style = DodoStyle(parentStyle: parentOne)
    
    XCTAssertEqual(100, style.bar.cornerRadius)
    
    // Now change the parent for the style
    // -------------------
    
    let parentTwo = DodoStyle()
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
    DodoBarDefaultStyles.cornerRadius = 213
    DodoLabelDefaultStyles.numberOfLines = 31
    DodoButtonDefaultStyles.horizontalMarginToBar = 41
    
    DodoStyle.resetDefaultStyles()
    
    XCTAssertEqual(20, DodoBarDefaultStyles.cornerRadius)
    XCTAssertEqual(3, DodoLabelDefaultStyles.numberOfLines)
    XCTAssertEqual(10, DodoButtonDefaultStyles.horizontalMarginToBar)
  }
  
  // MARK: - Clear
  
  func testClear() {
    DodoBarDefaultStyles.cornerRadius = 3
    DodoLabelDefaultStyles.numberOfLines = 4
    DodoButtonDefaultStyles.horizontalMarginToBar = 5
    
    // Parent styles
    // ------------------
    
    let parent = DodoStyle()
    parent.bar.cornerRadius = 30
    parent.label.numberOfLines = 40
    parent.leftButton.horizontalMarginToBar = 50
    parent.rightButton.horizontalMarginToBar = 51

    // Object styles
    // ------------------
    
    let style = DodoStyle(parentStyle: parent)
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