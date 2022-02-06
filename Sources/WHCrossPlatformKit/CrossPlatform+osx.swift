//
//  CrossPlatform+osx.swift
//  WHCrossPlatformKit
//
//  Created by William Hale on 1/30/16.
//

#if os(OSX)
    import AppKit

    extension NSScreen {

        /// Get the screen size of the main screen.
        /// - Returns: The screen size of the main screen.
        public static func getScreenSize() -> CGSize {
            let screen: NSScreen = NSScreen.main ?? NSScreen.screens[0]
            return screen.frame.size
        }
    }

    extension NSImage {

        /// Initializes and returns the image object with the specified Quartz image reference.
        /// - Parameter cgImage: A Quartz image reference.
        ///
        /// Cross platform with UIImage.
        public convenience init(cgImage: CGImage) {
            self.init(cgImage: cgImage, size:NSZeroSize)
        }

        /// The underlying Quartz image data.
        ///
        /// Cross platform with UIImage.
        public var cgImage:CGImage? {
            return self.cgImage(forProposedRect: nil, context: nil, hints: nil)
        }

        /// Draws the image at the specified point in the current context.
        /// - Parameter point: The point at which to draw the top-left corner of the image.
        ///
        /// Cross platform with UIImage.
        public func draw(at point:CGPoint) {
            let toRect = CGRect(x: point.x, y: point.y, width: size.width, height: size.height)
            draw(in: toRect, from: NSZeroRect, operation: .sourceOver, fraction: 1, respectFlipped: true, hints: nil)
        }
    }

    extension NSBezierPath {

        /// Creates and returns a new Bézier path object with a rounded rectangular path.
        /// - Parameters:
        ///   - roundedRect: The rectangle that defines the basic shape of the path.
        ///   - cornerRadius: The radius of each corner oval.
        ///   A value of 0 results in a rectangle without rounded corners.
        ///   Values larger than half the rectangle’s width or height are clamped appropriately to half the width or height.
        ///
        /// Cross platform with UIImage.
        public convenience init(roundedRect: CGRect, cornerRadius: CGFloat) {
            self.init(roundedRect: roundedRect, xRadius: cornerRadius, yRadius: cornerRadius)
        }

        /// Appends a straight line to the path.
        /// - Parameter point: The destination point of the line segment, specified in the current coordinate system.
        ///
        /// Cross platform with UIImage.
        public func addLine(to point:CGPoint) {
            line(to: point)
        }

        /// Appends an arc to the path.
        /// - Parameters:
        ///   - center: Specifies the center point of the circle (in the current coordinate system) used to define the arc.
        ///   - radius: Specifies the radius of the circle used to define the arc.
        ///   - startAngle: Specifies the starting angle of the arc (measured in radians).
        ///   - endAngle: Specifies the end angle of the arc (measured in radians).
        ///   - clockwise: The direction in which to draw the arc.
        ///
        /// Cross platform with UIImage.
        public func addArc(withCenter center: CGPoint, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat, clockwise: Bool) {
            appendArc(withCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
        }

        /// Appends the contents of the specified path object to the path.
        /// - Parameter path: The path to add to the receiver.
        ///
        /// Cross platform with UIImage.
        public func appendPath(_ path: NSBezierPath) {
            append(path)
        }

        /// Appends a cubic Bézier curve to the path.
        /// - Parameters:
        ///   - endPoint: The end point of the curve.
        ///   - controlPoint1: The first control point to use when computing the curve.
        ///   - controlPoint2: The second control point to use when computing the curve.
        ///
        /// Cross platform with UIImage.
        public func addCurve(to endPoint: NSPoint, controlPoint1: NSPoint, controlPoint2: NSPoint) {
            curve(to: endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        }

        /// Appends a quadratic Bézier curve to the path.
        /// - Parameters:
        ///   - endPoint: The end point of the curve.
        ///   - controlPoint: The control point of the curve.
        ///
        /// Cross platform with UIImage.
        public func addQuadCurve(to endPoint: NSPoint, controlPoint: NSPoint) {
            // from https://github.com/seivan/UIBezierPathPort/blob/develop/UIBezierPathPort/NSBezierPathExtension.swift

            let QP0 = self.currentPoint;
            let CP3 = endPoint;

            let CP1 = CGPoint(
                //  QP0   +   2   / 3    * (QP1   - QP0  )
                x: QP0.x + ((2.0 / 3.0) * (controlPoint.x - QP0.x)),
                y: QP0.y + ((2.0 / 3.0) * (controlPoint.y - QP0.y))
            );

            let CP2 = CGPoint(
                //  QP2   +  2   / 3    * (QP1   - QP2)
                x: endPoint.x + (2.0 / 3.0) * (controlPoint.x - endPoint.x),
                y: endPoint.y + (2.0 / 3.0) * (controlPoint.y - endPoint.y)
            )
            self.addCurve(to: CP3, controlPoint1: CP1, controlPoint2: CP2)
        }
    }

#endif
