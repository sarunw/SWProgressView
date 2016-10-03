//
//  SWProgressView.swift
//  Pods
//
//  Created by Sarun Wongpatcharapakorn on 10/3/16.
//
//

import UIKit

@IBDesignable
public class SWProgressView: UIView {
    
    /// The current progress shown by the receiver.
    @IBInspectable public var progress: CGFloat {
        didSet {
            setNeedsDisplay()
        }
    }
    
    /// The start point of the gradient.
    @IBInspectable public var startColor: UIColor {
        didSet {
            setNeedsDisplay()
        }
    }
    
    /// The end point of the gradient when drawn in the layer’s coordinate space. Animatable.
    @IBInspectable public var endColor: UIColor {
        didSet {
            setNeedsDisplay()
        }
    }
    
    /// A boolean value that determine whether the end point of the gradient's end color follow current progress.
    @IBInspectable public var dynamicEndPoint: Bool {
        didSet {
            setNeedsDisplay()
        }
    }
    
    public override init(frame: CGRect) {
        progress = 0
        startColor = UIColor.clear
        endColor = UIColor.clear
        dynamicEndPoint = false
        
        super.init(frame: frame)
        
        startColor = tintColor
        endColor = tintColor
    }
    
    public required init?(coder aDecoder: NSCoder) {
        progress = 0
        startColor = UIColor.clear
        endColor = UIColor.clear
        dynamicEndPoint = false
        
        super.init(coder: aDecoder)
        
        startColor = tintColor
        endColor = tintColor
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        let height = bounds.size.height
        layer.cornerRadius = cornerRadius
        
        clipsToBounds = true
    }
    
    public override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        
        context?.saveGState()
        
        let currentRect = rect
        let height = bounds.size.height
        let width = bounds.size.width
        
        // Fill
        let colors = [startColor.cgColor, endColor.cgColor]
        
        var locations: [CGFloat]!
        if dynamicEndPoint {
            locations = [0, progress]
        } else {
            locations = [0, 1]
        }
        
        // Clipping
        let progressRect = CGRect(x: 0, y: 0, width: progress * width, height: height)
        let progressPath = UIBezierPath(roundedRect: progressRect, cornerRadius: cornerRadius)
        
        context?.addPath(progressPath.cgPath)
        context?.clip()
        
        
        let baseSpace = CGColorSpaceCreateDeviceRGB()
        let gradient = CGGradient(colorsSpace: baseSpace, colors: colors as CFArray, locations: locations)!
        
        let start = CGPoint(x: 0, y: 0)
        let end = CGPoint(x: width, y: 0)
        context?.drawLinearGradient(gradient, start: start, end: end, options: [])
        
        context?.restoreGState()
    }
    
    private var cornerRadius: CGFloat {
        return bounds.size.height / 2
    }
}
