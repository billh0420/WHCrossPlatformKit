//
//  CrossPlatform.swift
//  WHCrossPlatformKit
//
//  Created by William Hale on 1/30/16.
//


#if os(iOS)
    import UIKit
#else
    import AppKit
#endif

#if os(iOS)
    /// Cross platform with NSFont.
    public typealias WHFont = UIFont

    /// Cross platform with NSImage.
    public typealias WHImage = UIImage

    /// Cross platform with NSBezierPath.
    public typealias WHBezierPath = UIBezierPath
#endif

#if os(OSX)
    /// Cross platform with UIFont.
    public typealias WHFont = NSFont

    /// Cross platform with UIImage.
    public typealias WHImage = NSImage

    /// Cross platform with UIBezierPath.
    public typealias WHBezierPath = NSBezierPath
#endif

/// A structure that provides a static function to create an offscreen image with a given size and with a given function to draw the content of the offscreen image.
public struct CrossPlatform {

    /// Creates an offscreen image with a given size and with a given function to draw the content of the offscreen image.
    /// - Parameters:
    ///   - size: The size (measured in points) for the new image.
    ///   - drawWithContext: A function to draw the content of the offscreen image.
    /// - Returns: The new offscreeen image.
    public static func offscreenImageWithSize(_ size:CGSize, drawWithContext:(CGContext) -> ()) -> WHImage {
        var image:WHImage?
        var context:CGContext?

        #if os(iOS)
            UIGraphicsBeginImageContextWithOptions(size, false, 0)
            context = UIGraphicsGetCurrentContext()
        #else
            image = WHImage(size:size)
            if let image = image {
                image.lockFocusFlipped(true) // wch: note this
                context = NSGraphicsContext.current?.cgContext
            }
        #endif

        if let context = context {
            context.setAllowsAntialiasing(true)
            context.clip(to: CGRect(origin: .zero, size: size))
            context.clear(CGRect(origin: .zero, size: size))
            drawWithContext(context)
        }

        #if os(iOS)
            if context != nil {
                image = UIGraphicsGetImageFromCurrentImageContext()
            }
            UIGraphicsEndImageContext()
        #else
            if let image = image {
                image.unlockFocus()
            }
        #endif

        if let image = image, context != nil {
            return image
        }
        else {
            fatalError("Cannot create offscreenImageWithSize=\(size)")
        }
    }
}
