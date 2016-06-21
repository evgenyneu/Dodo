import UIKit

struct PixelColor {
  /// Returns image color at specific point
  static func colorForPoint(_ image: UIImage, point: CGPoint) -> UIColor {
    let pixelData = image.cgImage?.dataProvider?.data
    let data = CFDataGetBytePtr(pixelData)
    
    let pixelInfo: Int = Int(((image.size.width * point.y) + point.x)) * 4; // 4 bytes per pixel
    
    let red: UInt8 = data![pixelInfo + 0]
    let green: UInt8 = data![pixelInfo + 1]
    let blue: UInt8 = data![pixelInfo + 2]
    let alpha: UInt8 = data![pixelInfo + 3]
    
    return UIColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: CGFloat(alpha) / 255.0)
  }
}
