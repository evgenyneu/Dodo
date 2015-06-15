//
//  TegAlign.swift
//
//  Collection of shortcuts to create autolayout constraints.
//

import UIKit

class TegAutolayoutConstraints {
  class func centerX(viewOne: UIView, viewTwo: UIView,
    constraintContainer: UIView) -> [NSLayoutConstraint] {
      
      return center(viewOne, viewTwo: viewTwo, constraintContainer: constraintContainer, vertically: false)
  }
  
  class func centerY(viewOne: UIView, viewTwo: UIView,
    constraintContainer: UIView) -> [NSLayoutConstraint] {
      
      return center(viewOne, viewTwo: viewTwo, constraintContainer: constraintContainer, vertically: true)
  }
  
  private class func center(viewOne: UIView, viewTwo: UIView,
    constraintContainer: UIView, vertically: Bool = false) -> [NSLayoutConstraint] {
      
      let attribute = vertically ? NSLayoutAttribute.CenterY : NSLayoutAttribute.CenterX
      
      let constraint = NSLayoutConstraint(
        item: viewOne,
        attribute: attribute,
        relatedBy: NSLayoutRelation.Equal,
        toItem: viewTwo,
        attribute: attribute,
        multiplier: 1,
        constant: 0)
      
      constraintContainer.addConstraint(constraint)
      
      return [constraint]
  }
  
  class func alignSameAttributes(item: AnyObject, toItem: AnyObject,
    constraintContainer: UIView, attribute: NSLayoutAttribute, margin: CGFloat = 0) -> [NSLayoutConstraint] {
      
      let constraint = NSLayoutConstraint(
        item: item,
        attribute: attribute,
        relatedBy: NSLayoutRelation.Equal,
        toItem: toItem,
        attribute: attribute,
        multiplier: 1,
        constant: margin)
      
      constraintContainer.addConstraint(constraint)
      
      return [constraint]
  }
  
  class func alignVerticallyToLayoutGuide(item: AnyObject, onTop: Bool,
    layoutGuide: UILayoutSupport, constraintContainer: UIView,
    margin: CGFloat = 0) -> [NSLayoutConstraint] {
      
    let constraint = NSLayoutConstraint(
      item: layoutGuide,
      attribute: onTop ? NSLayoutAttribute.Bottom : NSLayoutAttribute.Top,
      relatedBy: NSLayoutRelation.Equal,
      toItem: item,
      attribute: onTop ? NSLayoutAttribute.Top : NSLayoutAttribute.Bottom,
      multiplier: 1,
      constant: margin)
    
    constraintContainer.addConstraint(constraint)
    
    return [constraint]
  }
  
  class func aspectRatio(view: UIView, ratio: CGFloat) {
    let constraint = NSLayoutConstraint(
      item: view,
      attribute: NSLayoutAttribute.Width,
      relatedBy: NSLayoutRelation.Equal,
      toItem: view,
      attribute: NSLayoutAttribute.Height,
      multiplier: ratio,
      constant: 0)
    
    view.addConstraint(constraint)
  }
  
  class func fillParent(view: UIView, parentView: UIView, margin: CGFloat = 0, vertically: Bool = false) {
    var marginFormat = ""
    
    if margin != 0 {
      marginFormat = "-\(margin)-"
    }
    
    var format = "|\(marginFormat)[view]\(marginFormat)|"
    
    if vertically {
      format = "V:" + format
    }
    
    let constraints = NSLayoutConstraint.constraintsWithVisualFormat(format,
      options: [], metrics: nil,
      views: ["view": view])
    
    parentView.addConstraints(constraints)
  }
  
  class func viewsNextToEachOther(views: [UIView],
    constraintContainer: UIView, margin: CGFloat = 0,
    vertically: Bool = false) -> [NSLayoutConstraint] {
      
    if views.count < 2 { return []  }
      
    var constraints = [NSLayoutConstraint]()
      
    for (index, view) in views.enumerate() {
      if index >= views.count - 1 { break }
      
      let viewTwo = views[index + 1]
      
      constraints += twoViewsNextToEachOther(view, viewTwo: viewTwo,
        constraintContainer: constraintContainer, margin: margin, vertically: vertically)
    }
      
    return constraints
  }
  
  class func twoViewsNextToEachOther(viewOne: UIView, viewTwo: UIView,
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
    
    let constraints = NSLayoutConstraint.constraintsWithVisualFormat(format,
      options: [], metrics: nil,
      views: [ "viewOne": viewOne, "viewTwo": viewTwo ])
        
    constraintContainer.addConstraints(constraints)
    
    return constraints
  }
  
  class func equalWidth(viewOne: UIView, viewTwo: UIView,
    constraintContainer: UIView) -> [NSLayoutConstraint] {
      
    let constraints = NSLayoutConstraint.constraintsWithVisualFormat("[viewOne(==viewTwo)]",
        options: [], metrics: nil,
        views: ["viewOne": viewOne, "viewTwo": viewTwo])
          
          
    constraintContainer.addConstraints(constraints)
    
    return constraints
  }
  
  class func height(view: UIView, value: CGFloat) -> [NSLayoutConstraint] {
    return widthOrHeight(view, value: value, isWidth: false)
  }
  
  class func width(view: UIView, value: CGFloat) -> [NSLayoutConstraint] {
    return widthOrHeight(view, value: value, isWidth: true)
  }
  
  private class func widthOrHeight(view: UIView, value: CGFloat,
    isWidth: Bool) -> [NSLayoutConstraint] {
    
    let attribute = isWidth ? NSLayoutAttribute.Width : NSLayoutAttribute.Height
      
    let constraint = NSLayoutConstraint(
      item: view,
      attribute: attribute,
      relatedBy: NSLayoutRelation.Equal,
      toItem: nil,
      attribute: NSLayoutAttribute.NotAnAttribute,
      multiplier: 1,
      constant: value)
    
    view.addConstraint(constraint)
    
    return [constraint]
  }
}
