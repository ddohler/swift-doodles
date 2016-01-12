// Guard/Defer examples, from http://nshipster.com/guard-and-defer/
import UIKit

enum ConversionError : ErrorType {
  case InvalidFormat, OutOfBounds, Unknown
}

// This...
//extension UInt8 {
//  init(fromString string: String) throws {
//    // check the string's format
//    if let _ = string.rangeOfString("^\\d+$", options: [.RegularExpressionSearch]) {
//      
//      // make sure the value is in bounds
//      if string.compare("\(UInt8.max)", options: [.NumericSearch]) != NSComparisonResult.OrderedAscending {
//        throw ConversionError.OutOfBounds
//      }
//      
//      // do the built-in conversion
//      if let value = UInt8(string) {
//        self.init(value)
//      } else {
//        throw ConversionError.Unknown
//      }
//    }
//    
//    throw ConversionError.InvalidFormat
//  }
//}

// To this...
extension UInt8 {
  init(fromString string: String) throws {
    // check the string's format
    guard let _ = string.rangeOfString("^\\d+$", options: [.RegularExpressionSearch])
      else { throw ConversionError.InvalidFormat }
    
    // make sure the value is in bounds
    guard string.compare("\(UInt8.max)", options: [.NumericSearch]) != NSComparisonResult.OrderedDescending
      else { throw ConversionError.OutOfBounds }
    
    // do the built-in conversion
    guard let value = UInt(string)
      else { throw ConversionError.Unknown }
    
    self.init(value)
  }
}


// DEFER
func resizeImage(url: NSURL) -> UIImage? {
  // ...
  let dataSize: Int = ...
  let destData = UnsafeMutablePointer<UInt8>.alloc(dataSize)
  
  // Defers are called in reverse definition order
  //  Limit use to cleanup resources
  defer {
    destData.dealloc(dataSize)
  }
  
  var destBuffer = vImage_Buffer(data: destData, ...)
  
  // scale the image from sourceBuffer to destBuffer
  var error = vImageScale_ARGB8888(&sourceBuffer, &destBuffer, ...)
  guard error == kvImageNoError
    else { return nil }
  
  // create a CGImage from the destBuffer
  guard let destCGImage = vImageCreateCGImageFromBuffer(&destBuffer, &format, ...)
    else { return nil }
  // ...
}

// Implementation of postfix operator
postfix func ++(inout x: Int) -> Int {
  let current = x
  x += 1
  return current
}

// Doing it this way is possible, but dangerous, far less readable
postfix func ++(inout x: Int) -> Int {
  defer { x += 1 }
  return x
}

