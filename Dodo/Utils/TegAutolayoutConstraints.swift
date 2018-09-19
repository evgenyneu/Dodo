//
//  TegAlign.swift
//
//  Collection of shortcuts to create autolayout constraints.
//

import UIKit

class TegAutolayoutConstraints {
  class func centerX(_ viewOne: UIView, viewTwo: UIView,
    constraintContainer: UIView) -> [NSLayoutConstraint] {
      
      return center(viewOne, viewTwo: viewTwo, constraintContainer: constraintContainer, vertically: false)
  }
  
  @discardableResult
  class func centerY(_ viewOne: UIView, viewTwo: UIView,
    constraintContainer: UIView) -> [NSLayoutConstraint] {
      
      return center(viewOne, viewTwo: viewTwo, constraintContainer: constraintContainer, vertically: true)
  }
  
  private class func center(_ viewOne: UIView, viewTwo: UIView,
    constraintContainer: UIView, vertically: Bool = false) -> [NSLayoutConstraint] {
      
      let attribute = vertically ? NSLayoutConstraint.Attribute.centerY : NSLayoutConstraint.Attribute.centerX
      
      let constraint = NSLayoutConstraint(
        item: viewOne,
        attribute: attribute,
        relatedBy: NSLayoutConstraint.Relation.equal,
        toItem: viewTwo,
        attribute: attribute,
        multiplier: 1,
        constant: 0)
      
      constraintContainer.addConstraint(constraint)
      
      return [constraint]
  }
  
  @discardableResult
  class func alignSameAttributes(_ item: AnyObject, toItem: AnyObject,
    constraintContainer: UIView, attribute: NSLayoutConstraint.Attribute, margin: CGFloat = 0) -> [NSLayoutConstraint] {
      
      let constraint = NSLayoutConstraint(
        item: item,
        attribute: attribute,
        relatedBy: NSLayoutConstraint.Relation.equal,
        toItem: toItem,
        attribute: attribute,
        multiplier: 1,
        constant: margin)
      
      constraintContainer.addConstraint(constraint)
      
      return [constraint]
  }
  
  class func alignVerticallyToAnchor(_ item: AnyObject, onTop: Bool,
                                          anchor: NSLayoutYAxisAnchor,
                                          margin: CGFloat = 0) -> [NSLayoutConstraint] {
    
    
    let constraint = onTop ? anchor.constraint(equalTo: item.topAnchor) : anchor.constraint(equalTo: item.bottomAnchor)
    
    constraint.constant = margin
    constraint.isActive = true
    
    return [constraint]
  }
  
  class func aspectRatio(_ view: UIView, ratio: CGFloat) {
    let constraint = NSLayoutConstraint(
      item: view,
      attribute: NSLayoutConstraint.Attribute.width,
      relatedBy: NSLayoutConstraint.Relation.equal,
      toItem: view,
      attribute: NSLayoutConstraint.Attribute.height,
      multiplier: ratio,
      constant: 0)
    
    view.addConstraint(constraint)
  }
  
  class func fillParent(_ view: UIView, parentView: UIView, margin: CGFloat = 0, vertically: Bool = false) {
    var marginFormat = ""
    
    if margin != 0 {
      marginFormat = "-\(margin)-"
    }
    
    var format = "|\(marginFormat)[view]\(marginFormat)|"
    
    if vertically {
      format = "V:" + format
    }
    
    let constraints = NSLayoutConstraint.constraints(withVisualFormat: format,
      options: [], metrics: nil,
      views: ["view": view])
    
    parentView.addConstraints(constraints)
  }
  
  @discardableResult
  class func viewsNextToEachOther(_ views: [UIView],
    constraintContainer: UIView, margin: CGFloat = 0,
    vertically: Bool = false) -> [NSLayoutConstraint] {
      
    if views.count < 2 { return []  }
      
    var constraints = [NSLayoutConstraint]()
      
    for (index, view) in views.enumerated() {
      if index >= views.count - 1 { break }
      
      let viewTwo = views[index + 1]
      
      constraints += twoViewsNextToEachOther(view, viewTwo: viewTwo,
        constraintContainer: constraintContainer, margin: margin, vertically: vertically)
    }
      
    return constraints
  }
  
  class func twoViewsNextToEachOther(_ viewOne: UIView, viewTwo: UIView,
    constraintContainer: UIView, margin: CGFloat = 0,
    vertically: Bool = false) -> [NSLayoutConstraint] {
      
    var marginFormat = ""
    
    if margin != 0 {
      marginFormat = "-\(margin)-"
    }
    
    var format = "[viewOne]\(marginFormat)[viewTwo]"
    
    if vertically {
      format = "V:" + format
    }
    
    let constraints = NSLayoutConstraint.constraints(withVisualFormat: format,
      options: [], metrics: nil,
      views: [ "viewOne": viewOne, "viewTwo": viewTwo ])
        
    constraintContainer.addConstraints(constraints)
    
    return constraints
  }
  
  class func equalWidth(_ viewOne: UIView, viewTwo: UIView,
    constraintContainer: UIView) -> [NSLayoutConstraint] {
      
    let constraints = NSLayoutConstraint.constraints(withVisualFormat: "[viewOne(==viewTwo)]",
        options: [], metrics: nil,
        views: ["viewOne": viewOne, "viewTwo": viewTwo])
          
          
    constraintContainer.addConstraints(constraints)
    
    return constraints
  }
  
  @discardableResult
  class func height(_ view: UIView, value: CGFloat) -> [NSLayoutConstraint] {
    return widthOrHeight(view, value: value, isWidth: false)
  }
  
  @discardableResult
  class func width(_ view: UIView, value: CGFloat) -> [NSLayoutConstraint] {
    return widthOrHeight(view, value: value, isWidth: true)
  }
  
  private class func widthOrHeight(_ view: UIView, value: CGFloat,
    isWidth: Bool) -> [NSLayoutConstraint] {
    
    let attribute = isWidth ? NSLayoutConstraint.Attribute.width : NSLayoutConstraint.Attribute.height
      
    let constraint = NSLayoutConstraint(
      item: view,
      attribute: attribute,
      relatedBy: NSLayoutConstraint.Relation.equal,
      toItem: nil,
      attribute: NSLayoutConstraint.Attribute.notAnAttribute,
      multiplier: 1,
      constant: value)
    
    view.addConstraint(constraint)
    
    return [constraint]
  }
}
