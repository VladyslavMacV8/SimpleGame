//
//  StyleKitName.swift
//  Single App
//


import UIKit

class StyleKitName: UIView {
    //// Cache
    
    private struct Cache {
        static let gradientColor: UIColor = UIColor(red: 1.000, green: 0.000, blue: 0.000, alpha: 1.000)
        static let gradientColor2: UIColor = UIColor(red: 0.946, green: 1.000, blue: 0.000, alpha: 1.000)
        static let gradient2Color: UIColor = UIColor(red: 1.000, green: 0.000, blue: 0.000, alpha: 1.000)
        static let gradient2Color2: UIColor = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000)
        static let shadowColor: UIColor = UIColor(red: 1.000, green: 0.024, blue: 0.024, alpha: 1.000)
        static let gradient: CGGradient = CGGradient(colorsSpace: nil, colors: [StyleKitName.gradientColor.cgColor, StyleKitName.gradientColor2.cgColor] as CFArray, locations: [0, 1])!
        static let gradient2: CGGradient = CGGradient(colorsSpace: nil, colors: [StyleKitName.gradient2Color.cgColor, StyleKitName.gradient2Color.blended(withFraction: 0.5, of: StyleKitName.gradient2Color2).cgColor, StyleKitName.gradient2Color2.cgColor] as CFArray, locations: [0, 0.67, 1])!
        static let shadow: NSShadow = NSShadow(color: StyleKitName.shadowColor, offset: CGSize(width: -2, height: 2), blurRadius: 10)
    }
    
    //// Colors
    
    public dynamic class var gradientColor: UIColor { return Cache.gradientColor }
    public dynamic class var gradientColor2: UIColor { return Cache.gradientColor2 }
    public dynamic class var gradient2Color: UIColor { return Cache.gradient2Color }
    public dynamic class var gradient2Color2: UIColor { return Cache.gradient2Color2 }
    public dynamic class var shadowColor: UIColor { return Cache.shadowColor }
    
    //// Gradients
    
    public dynamic class var gradient: CGGradient { return Cache.gradient }
    public dynamic class var gradient2: CGGradient { return Cache.gradient2 }
    
    //// Shadows
    
    public dynamic class var shadow: NSShadow { return Cache.shadow }
    
    //// Drawing Methods
    
    public dynamic class func drawPlay(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 100, height: 100), resizing: ResizingBehavior = .aspectFit) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 250, height: 250), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 250, y: resizedFrame.height / 250)
        let resizedShadowScale: CGFloat = min(resizedFrame.width / 250, resizedFrame.height / 250)
        
        
        //// Oval Drawing
        let ovalPath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 250, height: 250))
        context.saveGState()
        ovalPath.addClip()
        context.drawLinearGradient(StyleKitName.gradient, start: CGPoint(x: 125, y: 0), end: CGPoint(x: 125, y: 250), options: [])
        context.restoreGState()
        
        ////// Oval Inner Shadow
        context.saveGState()
        context.clip(to: ovalPath.bounds)
        context.setShadow(offset: CGSize.zero, blur: 0)
        context.setAlpha((StyleKitName.shadow.shadowColor as! UIColor).cgColor.alpha)
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        let ovalOpaqueShadow = (StyleKitName.shadow.shadowColor as! UIColor).withAlphaComponent(1)
        context.setShadow(offset: CGSize(width: StyleKitName.shadow.shadowOffset.width * resizedShadowScale, height: StyleKitName.shadow.shadowOffset.height * resizedShadowScale), blur: StyleKitName.shadow.shadowBlurRadius * resizedShadowScale, color: ovalOpaqueShadow.cgColor)
        context.setBlendMode(.sourceOut)
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        
        ovalOpaqueShadow.setFill()
        ovalPath.fill()
        
        context.endTransparencyLayer()
        context.endTransparencyLayer()
        context.restoreGState()
        
        
        
        //// Triangle Drawing
        context.saveGState()
        context.translateBy(x: 125, y: 125)
        context.rotate(by: 90 * CGFloat.pi/180)
        
        let trianglePath = UIBezierPath()
        trianglePath.move(to: CGPoint(x: -0, y: -62.5))
        trianglePath.addLine(to: CGPoint(x: 54.13, y: 31.25))
        trianglePath.addLine(to: CGPoint(x: -54.13, y: 31.25))
        trianglePath.close()
        context.saveGState()
        trianglePath.addClip()
        context.drawLinearGradient(StyleKitName.gradient2, start: CGPoint(x: -0, y: -62.5), end: CGPoint(x: -0, y: 31.25), options: [])
        context.restoreGState()
        
        ////// Triangle Inner Shadow
        context.saveGState()
        context.clip(to: trianglePath.bounds)
        context.setShadow(offset: CGSize.zero, blur: 0)
        context.setAlpha((StyleKitName.shadow.shadowColor as! UIColor).cgColor.alpha)
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        let triangleOpaqueShadow = (StyleKitName.shadow.shadowColor as! UIColor).withAlphaComponent(1)
        context.setShadow(offset: CGSize(width: StyleKitName.shadow.shadowOffset.width * resizedShadowScale, height: StyleKitName.shadow.shadowOffset.height * resizedShadowScale), blur: StyleKitName.shadow.shadowBlurRadius * resizedShadowScale, color: triangleOpaqueShadow.cgColor)
        context.setBlendMode(.sourceOut)
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        
        triangleOpaqueShadow.setFill()
        trianglePath.fill()
        
        context.endTransparencyLayer()
        context.endTransparencyLayer()
        context.restoreGState()
        
        context.saveGState()
        context.setShadow(offset: CGSize(width: StyleKitName.shadow.shadowOffset.width * resizedShadowScale, height: StyleKitName.shadow.shadowOffset.height * resizedShadowScale), blur: StyleKitName.shadow.shadowBlurRadius * resizedShadowScale, color: (StyleKitName.shadow.shadowColor as! UIColor).cgColor)
        StyleKitName.gradientColor.setStroke()
        trianglePath.lineWidth = 3
        trianglePath.lineJoinStyle = .round
        trianglePath.stroke()
        context.restoreGState()
        
        context.restoreGState()
        
        context.restoreGState()
        
    }
    
    public dynamic class func drawPause(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 100, height: 100), resizing: ResizingBehavior = .aspectFit) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 250, height: 250), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 250, y: resizedFrame.height / 250)
        let resizedShadowScale: CGFloat = min(resizedFrame.width / 250, resizedFrame.height / 250)
        
        
        //// Oval Drawing
        let ovalPath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 250, height: 250))
        context.saveGState()
        ovalPath.addClip()
        context.drawLinearGradient(StyleKitName.gradient, start: CGPoint(x: 125, y: 0), end: CGPoint(x: 125, y: 250), options: [])
        context.restoreGState()
        
        ////// Oval Inner Shadow
        context.saveGState()
        context.clip(to: ovalPath.bounds)
        context.setShadow(offset: CGSize.zero, blur: 0)
        context.setAlpha((StyleKitName.shadow.shadowColor as! UIColor).cgColor.alpha)
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        let ovalOpaqueShadow = (StyleKitName.shadow.shadowColor as! UIColor).withAlphaComponent(1)
        context.setShadow(offset: CGSize(width: StyleKitName.shadow.shadowOffset.width * resizedShadowScale, height: StyleKitName.shadow.shadowOffset.height * resizedShadowScale), blur: StyleKitName.shadow.shadowBlurRadius * resizedShadowScale, color: ovalOpaqueShadow.cgColor)
        context.setBlendMode(.sourceOut)
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        
        ovalOpaqueShadow.setFill()
        ovalPath.fill()
        
        context.endTransparencyLayer()
        context.endTransparencyLayer()
        context.restoreGState()
        
        
        
        //// Triangle 2 Drawing
        context.saveGState()
        context.translateBy(x: 76.5, y: 123.5)
        context.rotate(by: 90 * CGFloat.pi/180)
        
        let triangle2Path = UIBezierPath()
        triangle2Path.move(to: CGPoint(x: -0, y: -62.5))
        triangle2Path.addLine(to: CGPoint(x: 54.13, y: 31.25))
        triangle2Path.addLine(to: CGPoint(x: -54.13, y: 31.25))
        triangle2Path.close()
        context.saveGState()
        triangle2Path.addClip()
        context.drawLinearGradient(StyleKitName.gradient2, start: CGPoint(x: -0, y: -62.5), end: CGPoint(x: -0, y: 31.25), options: [])
        context.restoreGState()
        
        ////// Triangle 2 Inner Shadow
        context.saveGState()
        context.clip(to: triangle2Path.bounds)
        context.setShadow(offset: CGSize.zero, blur: 0)
        context.setAlpha((StyleKitName.shadow.shadowColor as! UIColor).cgColor.alpha)
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        let triangle2OpaqueShadow = (StyleKitName.shadow.shadowColor as! UIColor).withAlphaComponent(1)
        context.setShadow(offset: CGSize(width: StyleKitName.shadow.shadowOffset.width * resizedShadowScale, height: StyleKitName.shadow.shadowOffset.height * resizedShadowScale), blur: StyleKitName.shadow.shadowBlurRadius * resizedShadowScale, color: triangle2OpaqueShadow.cgColor)
        context.setBlendMode(.sourceOut)
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        
        triangle2OpaqueShadow.setFill()
        triangle2Path.fill()
        
        context.endTransparencyLayer()
        context.endTransparencyLayer()
        context.restoreGState()
        
        context.saveGState()
        context.setShadow(offset: CGSize(width: StyleKitName.shadow.shadowOffset.width * resizedShadowScale, height: StyleKitName.shadow.shadowOffset.height * resizedShadowScale), blur: StyleKitName.shadow.shadowBlurRadius * resizedShadowScale, color: (StyleKitName.shadow.shadowColor as! UIColor).cgColor)
        StyleKitName.gradientColor.setStroke()
        triangle2Path.lineWidth = 3
        triangle2Path.lineJoinStyle = .round
        triangle2Path.stroke()
        context.restoreGState()
        
        context.restoreGState()
        
        
        //// Rectangle Drawing
        let rectanglePath = UIBezierPath(rect: CGRect(x: 151.5, y: 60.5, width: 20, height: 125))
        context.saveGState()
        rectanglePath.addClip()
        context.drawLinearGradient(StyleKitName.gradient2, start: CGPoint(x: 171.5, y: 123), end: CGPoint(x: 151.5, y: 123), options: [])
        context.restoreGState()
        
        ////// Rectangle Inner Shadow
        context.saveGState()
        context.clip(to: rectanglePath.bounds)
        context.setShadow(offset: CGSize.zero, blur: 0)
        context.setAlpha((StyleKitName.shadow.shadowColor as! UIColor).cgColor.alpha)
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        let rectangleOpaqueShadow = (StyleKitName.shadow.shadowColor as! UIColor).withAlphaComponent(1)
        context.setShadow(offset: CGSize(width: StyleKitName.shadow.shadowOffset.width * resizedShadowScale, height: StyleKitName.shadow.shadowOffset.height * resizedShadowScale), blur: StyleKitName.shadow.shadowBlurRadius * resizedShadowScale, color: rectangleOpaqueShadow.cgColor)
        context.setBlendMode(.sourceOut)
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        
        rectangleOpaqueShadow.setFill()
        rectanglePath.fill()
        
        context.endTransparencyLayer()
        context.endTransparencyLayer()
        context.restoreGState()
        
        context.saveGState()
        context.setShadow(offset: CGSize(width: StyleKitName.shadow.shadowOffset.width * resizedShadowScale, height: StyleKitName.shadow.shadowOffset.height * resizedShadowScale), blur: StyleKitName.shadow.shadowBlurRadius * resizedShadowScale, color: (StyleKitName.shadow.shadowColor as! UIColor).cgColor)
        StyleKitName.gradientColor.setStroke()
        rectanglePath.lineWidth = 3
        rectanglePath.lineJoinStyle = .round
        rectanglePath.stroke()
        context.restoreGState()
        
        
        //// Rectangle 2 Drawing
        let rectangle2Path = UIBezierPath(rect: CGRect(x: 183.5, y: 60.5, width: 20, height: 125))
        context.saveGState()
        rectangle2Path.addClip()
        context.drawLinearGradient(StyleKitName.gradient2, start: CGPoint(x: 203.5, y: 123), end: CGPoint(x: 183.5, y: 123), options: [])
        context.restoreGState()
        
        ////// Rectangle 2 Inner Shadow
        context.saveGState()
        context.clip(to: rectangle2Path.bounds)
        context.setShadow(offset: CGSize.zero, blur: 0)
        context.setAlpha((StyleKitName.shadow.shadowColor as! UIColor).cgColor.alpha)
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        let rectangle2OpaqueShadow = (StyleKitName.shadow.shadowColor as! UIColor).withAlphaComponent(1)
        context.setShadow(offset: CGSize(width: StyleKitName.shadow.shadowOffset.width * resizedShadowScale, height: StyleKitName.shadow.shadowOffset.height * resizedShadowScale), blur: StyleKitName.shadow.shadowBlurRadius * resizedShadowScale, color: rectangle2OpaqueShadow.cgColor)
        context.setBlendMode(.sourceOut)
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        
        rectangle2OpaqueShadow.setFill()
        rectangle2Path.fill()
        
        context.endTransparencyLayer()
        context.endTransparencyLayer()
        context.restoreGState()
        
        context.saveGState()
        context.setShadow(offset: CGSize(width: StyleKitName.shadow.shadowOffset.width * resizedShadowScale, height: StyleKitName.shadow.shadowOffset.height * resizedShadowScale), blur: StyleKitName.shadow.shadowBlurRadius * resizedShadowScale, color: (StyleKitName.shadow.shadowColor as! UIColor).cgColor)
        StyleKitName.gradientColor.setStroke()
        rectangle2Path.lineWidth = 3
        rectangle2Path.lineJoinStyle = .round
        rectangle2Path.stroke()
        context.restoreGState()
        
        context.restoreGState()
        
    }
    
    public dynamic class func drawMenu(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 100, height: 100), resizing: ResizingBehavior = .aspectFit) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 250, height: 250), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 250, y: resizedFrame.height / 250)
        let resizedShadowScale: CGFloat = min(resizedFrame.width / 250, resizedFrame.height / 250)
        
        
        //// Oval Drawing
        let ovalPath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 250, height: 250))
        context.saveGState()
        ovalPath.addClip()
        context.drawLinearGradient(StyleKitName.gradient, start: CGPoint(x: 125, y: 0), end: CGPoint(x: 125, y: 250), options: [])
        context.restoreGState()
        
        ////// Oval Inner Shadow
        context.saveGState()
        context.clip(to: ovalPath.bounds)
        context.setShadow(offset: CGSize.zero, blur: 0)
        context.setAlpha((StyleKitName.shadow.shadowColor as! UIColor).cgColor.alpha)
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        let ovalOpaqueShadow = (StyleKitName.shadow.shadowColor as! UIColor).withAlphaComponent(1)
        context.setShadow(offset: CGSize(width: StyleKitName.shadow.shadowOffset.width * resizedShadowScale, height: StyleKitName.shadow.shadowOffset.height * resizedShadowScale), blur: StyleKitName.shadow.shadowBlurRadius * resizedShadowScale, color: ovalOpaqueShadow.cgColor)
        context.setBlendMode(.sourceOut)
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        
        ovalOpaqueShadow.setFill()
        ovalPath.fill()
        
        context.endTransparencyLayer()
        context.endTransparencyLayer()
        context.restoreGState()
        
        
        
        //// Group
        context.saveGState()
        context.setShadow(offset: CGSize(width: StyleKitName.shadow.shadowOffset.width * resizedShadowScale, height: StyleKitName.shadow.shadowOffset.height * resizedShadowScale), blur: StyleKitName.shadow.shadowBlurRadius * resizedShadowScale, color: (StyleKitName.shadow.shadowColor as! UIColor).cgColor)
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        
        
        //// Rectangle 3 Drawing
        context.saveGState()
        context.translateBy(x: 125, y: 85.5)
        context.rotate(by: 90 * CGFloat.pi/180)
        
        let rectangle3Path = UIBezierPath(rect: CGRect(x: -10, y: -62.5, width: 20, height: 125))
        context.saveGState()
        rectangle3Path.addClip()
        context.drawLinearGradient(StyleKitName.gradient2, start: CGPoint(x: -0, y: -62.5), end: CGPoint(x: 0, y: 62.5), options: [])
        context.restoreGState()
        
        ////// Rectangle 3 Inner Shadow
        context.saveGState()
        context.clip(to: rectangle3Path.bounds)
        context.setShadow(offset: CGSize.zero, blur: 0)
        context.setAlpha((StyleKitName.shadow.shadowColor as! UIColor).cgColor.alpha)
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        let rectangle3OpaqueShadow = (StyleKitName.shadow.shadowColor as! UIColor).withAlphaComponent(1)
        context.setShadow(offset: CGSize(width: StyleKitName.shadow.shadowOffset.width * resizedShadowScale, height: StyleKitName.shadow.shadowOffset.height * resizedShadowScale), blur: StyleKitName.shadow.shadowBlurRadius * resizedShadowScale, color: rectangle3OpaqueShadow.cgColor)
        context.setBlendMode(.sourceOut)
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        
        rectangle3OpaqueShadow.setFill()
        rectangle3Path.fill()
        
        context.endTransparencyLayer()
        context.endTransparencyLayer()
        context.restoreGState()
        
        StyleKitName.gradientColor.setStroke()
        rectangle3Path.lineWidth = 3
        rectangle3Path.lineJoinStyle = .round
        rectangle3Path.stroke()
        
        context.restoreGState()
        
        
        //// Rectangle Drawing
        context.saveGState()
        context.translateBy(x: 125, y: 124.5)
        context.rotate(by: 90 * CGFloat.pi/180)
        
        let rectanglePath = UIBezierPath(rect: CGRect(x: -10, y: -62.5, width: 20, height: 125))
        context.saveGState()
        rectanglePath.addClip()
        context.drawLinearGradient(StyleKitName.gradient2, start: CGPoint(x: -0, y: -62.5), end: CGPoint(x: 0, y: 62.5), options: [])
        context.restoreGState()
        
        ////// Rectangle Inner Shadow
        context.saveGState()
        context.clip(to: rectanglePath.bounds)
        context.setShadow(offset: CGSize.zero, blur: 0)
        context.setAlpha((StyleKitName.shadow.shadowColor as! UIColor).cgColor.alpha)
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        let rectangleOpaqueShadow = (StyleKitName.shadow.shadowColor as! UIColor).withAlphaComponent(1)
        context.setShadow(offset: CGSize(width: StyleKitName.shadow.shadowOffset.width * resizedShadowScale, height: StyleKitName.shadow.shadowOffset.height * resizedShadowScale), blur: StyleKitName.shadow.shadowBlurRadius * resizedShadowScale, color: rectangleOpaqueShadow.cgColor)
        context.setBlendMode(.sourceOut)
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        
        rectangleOpaqueShadow.setFill()
        rectanglePath.fill()
        
        context.endTransparencyLayer()
        context.endTransparencyLayer()
        context.restoreGState()
        
        StyleKitName.gradientColor.setStroke()
        rectanglePath.lineWidth = 3
        rectanglePath.lineJoinStyle = .round
        rectanglePath.stroke()
        
        context.restoreGState()
        
        
        //// Rectangle 2 Drawing
        context.saveGState()
        context.translateBy(x: 125, y: 165)
        context.rotate(by: 90 * CGFloat.pi/180)
        
        let rectangle2Path = UIBezierPath(rect: CGRect(x: -10, y: -62.5, width: 20, height: 125))
        context.saveGState()
        rectangle2Path.addClip()
        context.drawLinearGradient(StyleKitName.gradient2, start: CGPoint(x: -0, y: -62.5), end: CGPoint(x: 0, y: 62.5), options: [])
        context.restoreGState()
        
        ////// Rectangle 2 Inner Shadow
        context.saveGState()
        context.clip(to: rectangle2Path.bounds)
        context.setShadow(offset: CGSize.zero, blur: 0)
        context.setAlpha((StyleKitName.shadow.shadowColor as! UIColor).cgColor.alpha)
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        let rectangle2OpaqueShadow = (StyleKitName.shadow.shadowColor as! UIColor).withAlphaComponent(1)
        context.setShadow(offset: CGSize(width: StyleKitName.shadow.shadowOffset.width * resizedShadowScale, height: StyleKitName.shadow.shadowOffset.height * resizedShadowScale), blur: StyleKitName.shadow.shadowBlurRadius * resizedShadowScale, color: rectangle2OpaqueShadow.cgColor)
        context.setBlendMode(.sourceOut)
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        
        rectangle2OpaqueShadow.setFill()
        rectangle2Path.fill()
        
        context.endTransparencyLayer()
        context.endTransparencyLayer()
        context.restoreGState()
        
        StyleKitName.gradientColor.setStroke()
        rectangle2Path.lineWidth = 3
        rectangle2Path.lineJoinStyle = .round
        rectangle2Path.stroke()
        
        context.restoreGState()
        
        
        context.endTransparencyLayer()
        context.restoreGState()
        
        context.restoreGState()
        
    }
    
    public dynamic class func drawInfo(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 100, height: 100), resizing: ResizingBehavior = .aspectFit) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 250, height: 250), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 250, y: resizedFrame.height / 250)
        let resizedShadowScale: CGFloat = min(resizedFrame.width / 250, resizedFrame.height / 250)
        
        
        //// Oval 2 Drawing
        let oval2Path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 250, height: 250))
        context.saveGState()
        oval2Path.addClip()
        context.drawLinearGradient(StyleKitName.gradient, start: CGPoint(x: 125, y: 0), end: CGPoint(x: 125, y: 250), options: [])
        context.restoreGState()
        
        ////// Oval 2 Inner Shadow
        context.saveGState()
        context.clip(to: oval2Path.bounds)
        context.setShadow(offset: CGSize.zero, blur: 0)
        context.setAlpha((StyleKitName.shadow.shadowColor as! UIColor).cgColor.alpha)
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        let oval2OpaqueShadow = (StyleKitName.shadow.shadowColor as! UIColor).withAlphaComponent(1)
        context.setShadow(offset: CGSize(width: StyleKitName.shadow.shadowOffset.width * resizedShadowScale, height: StyleKitName.shadow.shadowOffset.height * resizedShadowScale), blur: StyleKitName.shadow.shadowBlurRadius * resizedShadowScale, color: oval2OpaqueShadow.cgColor)
        context.setBlendMode(.sourceOut)
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        
        oval2OpaqueShadow.setFill()
        oval2Path.fill()
        
        context.endTransparencyLayer()
        context.endTransparencyLayer()
        context.restoreGState()
        
        
        
        //// Group
        context.saveGState()
        context.setShadow(offset: CGSize(width: StyleKitName.shadow.shadowOffset.width * resizedShadowScale, height: StyleKitName.shadow.shadowOffset.height * resizedShadowScale), blur: StyleKitName.shadow.shadowBlurRadius * resizedShadowScale, color: (StyleKitName.shadow.shadowColor as! UIColor).cgColor)
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        
        
        //// Rectangle 4 Drawing
        context.saveGState()
        context.translateBy(x: 125.5, y: 143)
        
        let rectangle4Path = UIBezierPath(rect: CGRect(x: -10, y: -62.5, width: 20, height: 125))
        context.saveGState()
        rectangle4Path.addClip()
        context.drawLinearGradient(StyleKitName.gradient2, start: CGPoint(x: 10, y: 0), end: CGPoint(x: -10, y: 0), options: [])
        context.restoreGState()
        
        ////// Rectangle 4 Inner Shadow
        context.saveGState()
        context.clip(to: rectangle4Path.bounds)
        context.setShadow(offset: CGSize.zero, blur: 0)
        context.setAlpha((StyleKitName.shadow.shadowColor as! UIColor).cgColor.alpha)
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        let rectangle4OpaqueShadow = (StyleKitName.shadow.shadowColor as! UIColor).withAlphaComponent(1)
        context.setShadow(offset: CGSize(width: StyleKitName.shadow.shadowOffset.width * resizedShadowScale, height: StyleKitName.shadow.shadowOffset.height * resizedShadowScale), blur: StyleKitName.shadow.shadowBlurRadius * resizedShadowScale, color: rectangle4OpaqueShadow.cgColor)
        context.setBlendMode(.sourceOut)
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        
        rectangle4OpaqueShadow.setFill()
        rectangle4Path.fill()
        
        context.endTransparencyLayer()
        context.endTransparencyLayer()
        context.restoreGState()
        
        StyleKitName.gradientColor.setStroke()
        rectangle4Path.lineWidth = 3
        rectangle4Path.lineJoinStyle = .round
        rectangle4Path.stroke()
        
        context.restoreGState()
        
        
        //// Oval Drawing
        let ovalPath = UIBezierPath(ovalIn: CGRect(x: 115.5, y: 44.5, width: 20, height: 20))
        context.saveGState()
        ovalPath.addClip()
        context.drawLinearGradient(StyleKitName.gradient2, start: CGPoint(x: 135.5, y: 54.5), end: CGPoint(x: 115.5, y: 54.5), options: [])
        context.restoreGState()
        
        ////// Oval Inner Shadow
        context.saveGState()
        context.clip(to: ovalPath.bounds)
        context.setShadow(offset: CGSize.zero, blur: 0)
        context.setAlpha((StyleKitName.shadow.shadowColor as! UIColor).cgColor.alpha)
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        let ovalOpaqueShadow = (StyleKitName.shadow.shadowColor as! UIColor).withAlphaComponent(1)
        context.setShadow(offset: CGSize(width: StyleKitName.shadow.shadowOffset.width * resizedShadowScale, height: StyleKitName.shadow.shadowOffset.height * resizedShadowScale), blur: StyleKitName.shadow.shadowBlurRadius * resizedShadowScale, color: ovalOpaqueShadow.cgColor)
        context.setBlendMode(.sourceOut)
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        
        ovalOpaqueShadow.setFill()
        ovalPath.fill()
        
        context.endTransparencyLayer()
        context.endTransparencyLayer()
        context.restoreGState()
        
        StyleKitName.gradientColor.setStroke()
        ovalPath.lineWidth = 3
        ovalPath.stroke()
        
        
        context.endTransparencyLayer()
        context.restoreGState()
        
        context.restoreGState()
        
    }
    
    public dynamic class func drawReset(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 100, height: 100), resizing: ResizingBehavior = .aspectFit) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 250, height: 250), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 250, y: resizedFrame.height / 250)
        let resizedShadowScale: CGFloat = min(resizedFrame.width / 250, resizedFrame.height / 250)
        
        
        //// Oval 3 Drawing
        let oval3Path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 250, height: 250))
        context.saveGState()
        oval3Path.addClip()
        context.drawLinearGradient(StyleKitName.gradient, start: CGPoint(x: 125, y: 0), end: CGPoint(x: 125, y: 250), options: [])
        context.restoreGState()
        
        ////// Oval 3 Inner Shadow
        context.saveGState()
        context.clip(to: oval3Path.bounds)
        context.setShadow(offset: CGSize.zero, blur: 0)
        context.setAlpha((StyleKitName.shadow.shadowColor as! UIColor).cgColor.alpha)
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        let oval3OpaqueShadow = (StyleKitName.shadow.shadowColor as! UIColor).withAlphaComponent(1)
        context.setShadow(offset: CGSize(width: StyleKitName.shadow.shadowOffset.width * resizedShadowScale, height: StyleKitName.shadow.shadowOffset.height * resizedShadowScale), blur: StyleKitName.shadow.shadowBlurRadius * resizedShadowScale, color: oval3OpaqueShadow.cgColor)
        context.setBlendMode(.sourceOut)
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        
        oval3OpaqueShadow.setFill()
        oval3Path.fill()
        
        context.endTransparencyLayer()
        context.endTransparencyLayer()
        context.restoreGState()
        
        
        
        //// Group
        //// Triangle Drawing
        context.saveGState()
        context.translateBy(x: 125.5, y: 80.5)
        context.rotate(by: 90 * CGFloat.pi/180)
        
        let trianglePath = UIBezierPath()
        trianglePath.move(to: CGPoint(x: -0, y: -62.5))
        trianglePath.addLine(to: CGPoint(x: 54.13, y: 31.25))
        trianglePath.addLine(to: CGPoint(x: -54.13, y: 31.25))
        trianglePath.close()
        context.saveGState()
        trianglePath.addClip()
        context.drawLinearGradient(StyleKitName.gradient2, start: CGPoint(x: -0, y: -62.5), end: CGPoint(x: -0, y: 31.25), options: [])
        context.restoreGState()
        
        ////// Triangle Inner Shadow
        context.saveGState()
        context.clip(to: trianglePath.bounds)
        context.setShadow(offset: CGSize.zero, blur: 0)
        context.setAlpha((StyleKitName.shadow.shadowColor as! UIColor).cgColor.alpha)
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        let triangleOpaqueShadow = (StyleKitName.shadow.shadowColor as! UIColor).withAlphaComponent(1)
        context.setShadow(offset: CGSize(width: StyleKitName.shadow.shadowOffset.width * resizedShadowScale, height: StyleKitName.shadow.shadowOffset.height * resizedShadowScale), blur: StyleKitName.shadow.shadowBlurRadius * resizedShadowScale, color: triangleOpaqueShadow.cgColor)
        context.setBlendMode(.sourceOut)
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        
        triangleOpaqueShadow.setFill()
        trianglePath.fill()
        
        context.endTransparencyLayer()
        context.endTransparencyLayer()
        context.restoreGState()
        
        context.saveGState()
        context.setShadow(offset: CGSize(width: StyleKitName.shadow.shadowOffset.width * resizedShadowScale, height: StyleKitName.shadow.shadowOffset.height * resizedShadowScale), blur: StyleKitName.shadow.shadowBlurRadius * resizedShadowScale, color: (StyleKitName.shadow.shadowColor as! UIColor).cgColor)
        StyleKitName.gradientColor.setStroke()
        trianglePath.lineWidth = 3
        trianglePath.lineJoinStyle = .round
        trianglePath.stroke()
        context.restoreGState()
        
        context.restoreGState()
        
        
        //// Triangle 2 Drawing
        context.saveGState()
        context.translateBy(x: 125.5, y: 168.5)
        context.rotate(by: -90 * CGFloat.pi/180)
        
        let triangle2Path = UIBezierPath()
        triangle2Path.move(to: CGPoint(x: -0, y: -62.5))
        triangle2Path.addLine(to: CGPoint(x: 54.13, y: 31.25))
        triangle2Path.addLine(to: CGPoint(x: -54.13, y: 31.25))
        triangle2Path.close()
        context.saveGState()
        triangle2Path.addClip()
        context.drawLinearGradient(StyleKitName.gradient2, start: CGPoint(x: -0, y: 31.25), end: CGPoint(x: -0, y: -62.5), options: [])
        context.restoreGState()
        
        ////// Triangle 2 Inner Shadow
        context.saveGState()
        context.clip(to: triangle2Path.bounds)
        context.setShadow(offset: CGSize.zero, blur: 0)
        context.setAlpha((StyleKitName.shadow.shadowColor as! UIColor).cgColor.alpha)
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        let triangle2OpaqueShadow = (StyleKitName.shadow.shadowColor as! UIColor).withAlphaComponent(1)
        context.setShadow(offset: CGSize(width: StyleKitName.shadow.shadowOffset.width * resizedShadowScale, height: StyleKitName.shadow.shadowOffset.height * resizedShadowScale), blur: StyleKitName.shadow.shadowBlurRadius * resizedShadowScale, color: triangle2OpaqueShadow.cgColor)
        context.setBlendMode(.sourceOut)
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        
        triangle2OpaqueShadow.setFill()
        triangle2Path.fill()
        
        context.endTransparencyLayer()
        context.endTransparencyLayer()
        context.restoreGState()
        
        context.saveGState()
        context.setShadow(offset: CGSize(width: StyleKitName.shadow.shadowOffset.width * resizedShadowScale, height: StyleKitName.shadow.shadowOffset.height * resizedShadowScale), blur: StyleKitName.shadow.shadowBlurRadius * resizedShadowScale, color: (StyleKitName.shadow.shadowColor as! UIColor).cgColor)
        StyleKitName.gradientColor.setStroke()
        triangle2Path.lineWidth = 3
        triangle2Path.lineJoinStyle = .round
        triangle2Path.stroke()
        context.restoreGState()
        
        context.restoreGState()
        
        context.restoreGState()
        
    }
    
    public dynamic class func drawScore(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 100, height: 100), resizing: ResizingBehavior = .aspectFit) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 250, height: 250), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 250, y: resizedFrame.height / 250)
        let resizedShadowScale: CGFloat = min(resizedFrame.width / 250, resizedFrame.height / 250)
        
        
        //// Oval 3 Drawing
        let oval3Path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 250, height: 250))
        context.saveGState()
        oval3Path.addClip()
        context.drawLinearGradient(StyleKitName.gradient, start: CGPoint(x: 125, y: 0), end: CGPoint(x: 125, y: 250), options: [])
        context.restoreGState()
        
        ////// Oval 3 Inner Shadow
        context.saveGState()
        context.clip(to: oval3Path.bounds)
        context.setShadow(offset: CGSize.zero, blur: 0)
        context.setAlpha((StyleKitName.shadow.shadowColor as! UIColor).cgColor.alpha)
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        let oval3OpaqueShadow = (StyleKitName.shadow.shadowColor as! UIColor).withAlphaComponent(1)
        context.setShadow(offset: CGSize(width: StyleKitName.shadow.shadowOffset.width * resizedShadowScale, height: StyleKitName.shadow.shadowOffset.height * resizedShadowScale), blur: StyleKitName.shadow.shadowBlurRadius * resizedShadowScale, color: oval3OpaqueShadow.cgColor)
        context.setBlendMode(.sourceOut)
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        
        oval3OpaqueShadow.setFill()
        oval3Path.fill()
        
        context.endTransparencyLayer()
        context.endTransparencyLayer()
        context.restoreGState()
        
        
        
        //// Star Drawing
        let starPath = UIBezierPath()
        starPath.move(to: CGPoint(x: 125, y: 50))
        starPath.addLine(to: CGPoint(x: 143.21, y: 99.94))
        starPath.addLine(to: CGPoint(x: 196.33, y: 101.82))
        starPath.addLine(to: CGPoint(x: 154.47, y: 134.57))
        starPath.addLine(to: CGPoint(x: 169.08, y: 185.68))
        starPath.addLine(to: CGPoint(x: 125, y: 155.98))
        starPath.addLine(to: CGPoint(x: 80.92, y: 185.68))
        starPath.addLine(to: CGPoint(x: 95.53, y: 134.57))
        starPath.addLine(to: CGPoint(x: 53.67, y: 101.82))
        starPath.addLine(to: CGPoint(x: 106.79, y: 99.94))
        starPath.close()
        context.saveGState()
        starPath.addClip()
        context.drawLinearGradient(StyleKitName.gradient2, start: CGPoint(x: 196.33, y: 117.84), end: CGPoint(x: 53.67, y: 117.84), options: [])
        context.restoreGState()
        
        ////// Star Inner Shadow
        context.saveGState()
        context.clip(to: starPath.bounds)
        context.setShadow(offset: CGSize.zero, blur: 0)
        context.setAlpha((StyleKitName.shadow.shadowColor as! UIColor).cgColor.alpha)
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        let starOpaqueShadow = (StyleKitName.shadow.shadowColor as! UIColor).withAlphaComponent(1)
        context.setShadow(offset: CGSize(width: StyleKitName.shadow.shadowOffset.width * resizedShadowScale, height: StyleKitName.shadow.shadowOffset.height * resizedShadowScale), blur: StyleKitName.shadow.shadowBlurRadius * resizedShadowScale, color: starOpaqueShadow.cgColor)
        context.setBlendMode(.sourceOut)
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        
        starOpaqueShadow.setFill()
        starPath.fill()
        
        context.endTransparencyLayer()
        context.endTransparencyLayer()
        context.restoreGState()
        
        context.saveGState()
        context.setShadow(offset: CGSize(width: StyleKitName.shadow.shadowOffset.width * resizedShadowScale, height: StyleKitName.shadow.shadowOffset.height * resizedShadowScale), blur: StyleKitName.shadow.shadowBlurRadius * resizedShadowScale, color: (StyleKitName.shadow.shadowColor as! UIColor).cgColor)
        StyleKitName.gradientColor.setStroke()
        starPath.lineWidth = 3
        starPath.lineCapStyle = .round
        starPath.lineJoinStyle = .round
        starPath.stroke()
        context.restoreGState()
        
        context.restoreGState()
        
    }
    
    @objc public enum ResizingBehavior: Int {
        case aspectFit /// The content is proportionally resized to fit into the target rectangle.
        case aspectFill /// The content is proportionally resized to completely fill the target rectangle.
        case stretch /// The content is stretched to match the entire target rectangle.
        case center /// The content is centered in the target rectangle, but it is NOT resized.
        
        public func apply(rect: CGRect, target: CGRect) -> CGRect {
            if rect == target || target == CGRect.zero {
                return rect
            }
            
            var scales = CGSize.zero
            scales.width = abs(target.width / rect.width)
            scales.height = abs(target.height / rect.height)
            
            switch self {
            case .aspectFit:
                scales.width = min(scales.width, scales.height)
                scales.height = scales.width
            case .aspectFill:
                scales.width = max(scales.width, scales.height)
                scales.height = scales.width
            case .stretch:
                break
            case .center:
                scales.width = 1
                scales.height = 1
            }
            
            var result = rect.standardized
            result.size.width *= scales.width
            result.size.height *= scales.height
            result.origin.x = target.minX + (target.width - result.width) / 2
            result.origin.y = target.minY + (target.height - result.height) / 2
            return result
        }
    }
}



extension UIColor {
    func blended(withFraction fraction: CGFloat, of color: UIColor) -> UIColor {
        var r1: CGFloat = 1, g1: CGFloat = 1, b1: CGFloat = 1, a1: CGFloat = 1
        var r2: CGFloat = 1, g2: CGFloat = 1, b2: CGFloat = 1, a2: CGFloat = 1
        
        self.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        color.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
        
        return UIColor(red: r1 * (1 - fraction) + r2 * fraction,
                       green: g1 * (1 - fraction) + g2 * fraction,
                       blue: b1 * (1 - fraction) + b2 * fraction,
                       alpha: a1 * (1 - fraction) + a2 * fraction);
    }
}



extension NSShadow {
    convenience init(color: AnyObject!, offset: CGSize, blurRadius: CGFloat) {
        self.init()
        self.shadowColor = color
        self.shadowOffset = offset
        self.shadowBlurRadius = blurRadius
    }
}

