import UIKit

/**
  
Creates a UIColor object from a string.

Examples:

    DodoColor.fromHexString('#340f9a')

    // With alpha channel
    DodoColor.fromHexString('#f1a2b3a6')

*/
public class DodoColor {
  /**
  
  Creates a UIColor object from a string.
  
  - parameter rgba: a RGB/RGBA string representation of color. It can include optional alpha value. Example: "#cca213" or "#cca21312" (with alpha value).
  
  - returns: UIColor object.
  
  */
  public class func fromHexString(_ rgba: String) -> UIColor {
    var red: CGFloat   = 0.0
    var green: CGFloat = 0.0
    var blue: CGFloat  = 0.0
    var alpha: CGFloat = 1.0
    
    if !rgba.hasPrefix("#") {
      print("Warning: DodoColor.fromHexString, # character missing")
      return UIColor()
    }
    
    let index = rgba.characters.index(rgba.startIndex, offsetBy: 1)
    let hex = String(rgba.suffix(from: index))
    let scanner = Scanner(string: hex)
    var hexValue: CUnsignedLongLong = 0
    
    if !scanner.scanHexInt64(&hexValue) {
      print("Warning: DodoColor.fromHexString, error scanning hex value")
      return UIColor()
    }

    if hex.characters.count == 6 {
      red   = CGFloat((hexValue & 0xFF0000) >> 16) / 255.0
      green = CGFloat((hexValue & 0x00FF00) >> 8)  / 255.0
      blue  = CGFloat(hexValue & 0x0000FF) / 255.0
    } else if hex.characters.count == 8 {
      red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
      green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
      blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
      alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
    } else {
      print("Warning: DodoColor.fromHexString, invalid rgb string, length should be 7 or 9")
      return UIColor()
    }
   
    return UIColor(red: red, green: green, blue: blue, alpha: alpha)
  }
}
