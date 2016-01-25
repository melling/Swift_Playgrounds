//: iOS Color Playground

import UIKit

/*: Standard UIColors
blackColor, blueColor, brownColor, clearColor, cyanColor, darkGrayColor, grayColor, greenColor, lightGrayColor, magentaColor, orangeColor, purpleColor, redColor, whiteColor, yellowColor
*/
let blackColor = UIColor.blackColor()
let whiteColor = UIColor.whiteColor()
let redColor = UIColor.redColor()
let blueColor = UIColor.blueColor()
let greenColor = UIColor.greenColor()
let clearColor = UIColor.clearColor()

//: Standard CGColors - Core Graphics
let blackCGColor = UIColor.blackColor().CGColor
let whiteCGColor = UIColor.whiteColor().CGColor
let redCGColor = UIColor.redColor().CGColor
let blueCGColor = UIColor.blueColor().CGColor
let greenCGColor = UIColor.greenColor().CGColor
let clearCGColor = UIColor.clearColor().CGColor


//: Gray

let gray:CGFloat = 255.0 // 0=black to 255=white

let aGrayColor = UIColor(red: gray/255.0, green:gray/255.0, blue:gray/255.0, alpha:1)


//: rgba
let color = UIColor(red: 200/255.0, green:100/255.0, blue:100/255.0, alpha:1)

let cgColor = UIColor(red: 200/255.0, green:100/255.0, blue:100/255.0, alpha:1).CGColor // Use with Core Graphics

//: Hue

let colorWithHue = UIColor(hue:0.625, saturation:0.0, brightness:0.85, alpha:1.0)

//: Color from Pattern

//let image = UIImage(named:"texture.png")
//let colorPattern = UIColor(patternImage: image!)

//if let image = UIImage(named:"texture.png") {
//    let colorPattern = UIColor(patternImage: image)
//}

