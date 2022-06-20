//
//  UIView+Extenstion.swift
//  CurrencyConversation
//
//  Created by Mubashshir on 6/15/22.
//

import Foundation
import AVKit
import UIKit

extension UIView {
    
    @IBInspectable var fixRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.masksToBounds = false
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
    
    @IBInspectable
    var roundBottomRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
            layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowColor = UIColor.lightGray.cgColor
            layer.shadowOffset = CGSize(width: 0, height: 2)
            layer.shadowOpacity = 0.4
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var roundTopRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
            layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
    }

}

extension UIView {
    //MARK: -Top Right Corner-
    func topRightRoundCorner(radius: CGFloat) {
        self.layer.cornerRadius = CGFloat(radius)
        self.clipsToBounds = true
        self.layer.maskedCorners = [.layerMinXMinYCorner]
    }
    //MARK: - Top Round Corner
    func topRoundCorner(radius: CGFloat) {
        self.layer.cornerRadius = CGFloat(radius)
        self.clipsToBounds = true
        self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    //MARK: - Bottom Round Corner
    func bottomRoundCorner(radius: CGFloat) {
        self.layer.cornerRadius = CGFloat(radius)
        self.clipsToBounds = true
        self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    //MARK: - Left Round Corner
    func leftRoundCorner(radius: CGFloat) {
        self.layer.cornerRadius = CGFloat(radius)
        self.clipsToBounds = true
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
    }
    
    //MARK: - Right Round Corner
    func rightRoundCorner(radius: CGFloat) {
        self.layer.cornerRadius = CGFloat(radius)
        self.clipsToBounds = true
        self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
    }
    
    //MARK: - Drop Shadow
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true){
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offSet
        self.layer.shadowRadius = radius
    }
    
    //MARK: - Page Master
    func fitToSelf(childView: UIView) {
        childView.translatesAutoresizingMaskIntoConstraints = false
        let bindings = ["childView": childView]
        self.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat : "H:|[childView]|",
                options          : [],
                metrics          : nil,
                views            : bindings
        ))
        self.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat : "V:|[childView]|",
                options          : [],
                metrics          : nil,
                views            : bindings
        ))
    }
    
    func applyGradient(withColours colours: [UIColor], gradientOrientation orientation: GradientOrientation) {
        let gradient = CAGradientLayer()
        gradient.frame = self.frame
        gradient.colors = colours.map { $0.cgColor }
        gradient.startPoint = orientation.startPoint
        gradient.endPoint = orientation.endPoint
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    typealias GradientPoints = (startPoint: CGPoint, endPoint: CGPoint)
    enum GradientOrientation {
        case topRightBottomLeft
        case topLeftBottomRight
        case horizontal
        
        case vertical
        case topBottom
        case bottomTop
        var startPoint : CGPoint {
            return points.startPoint
        }
        var endPoint : CGPoint {
            return points.endPoint
        }
        var points : GradientPoints {
            get {
                switch(self) {
                case .topRightBottomLeft:
                    return (CGPoint(x: 0.0,y: 1.0), CGPoint(x: 1.0,y: 0.0))
                case .topLeftBottomRight:
                    return (CGPoint(x: 0.0,y: 0.0), CGPoint(x: 1,y: 1))
                case .horizontal:
                    return (CGPoint(x: 0.0,y: 0.5), CGPoint(x: 1.0,y: 0.5))
                case .vertical:
                    return (CGPoint(x: 0.0,y: 0.0), CGPoint(x: 0.0,y: 1.0))
                case .topBottom:
                    return (CGPoint(x: 0.5, y: 0.6), CGPoint(x: 0.5,y: 1.0))
                case .bottomTop:
                    return (CGPoint(x: 0.5, y: 0.0), CGPoint(x: 0.5,y: 0.4))
                }
            }
        }
    }
    
    func shake(for duration: TimeInterval = 0.5, withTranslation translation: CGFloat = 10) {
        let propertyAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 0.3) {
            self.transform = CGAffineTransform(translationX: translation, y: 0)
        }
        
        propertyAnimator.addAnimations({
            self.transform = CGAffineTransform(translationX: 0, y: 0)
        }, delayFactor: 0.2)
        
        propertyAnimator.startAnimation()
    }
    
    func resignResponder(){
        for view in subviews{
            if let view = view as? UITextField{
                view.resignFirstResponder()
            } else {
                view.resignResponder()
            }
        }
    }
    
    func addBlur(_ alpha: CGFloat = 0.5) {
        // create effect
        let effect = UIBlurEffect(style: .dark)
        let effectView = UIVisualEffectView(effect: effect)

        // set boundry and alpha
        effectView.frame = self.bounds
        effectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        effectView.alpha = alpha

        self.addSubview(effectView)
    }
    
    func rotate360Degrees(duration: CFTimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat.pi
        rotateAnimation.duration = duration

        if let delegate: CAAnimationDelegate = completionDelegate as! CAAnimationDelegate? {
            rotateAnimation.delegate = delegate
        }
        self.layer.add(rotateAnimation, forKey: nil)
    }
    
}
extension UISwitch{
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.transform = CGAffineTransform.init(scaleX: 0.7, y: 0.7)
    }
}
extension UIView {
    
    func addSpinner() {
        self.addSpinner(withColor: UIColor.darkGray)
    }
    
    func addSpinner(withColor color: UIColor) {
        
        for sv in self.subviews {
            
            if sv.tag == -999 {
                
                sv.removeFromSuperview()
            }
        }
        let spinnerSize: CGFloat = 50.0
        let spinner = UIActivityIndicatorView(style: .gray)
        spinner.tag = -999
        spinner.frame = CGRect(x: 0, y: 0, width: spinnerSize, height: spinnerSize)
        spinner.color = color
        spinner.center = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        self.addSubview(spinner)
        spinner.startAnimating()
    }
    
    func removeSpinner() {
        for sv in self.subviews {
            if sv.tag == -999 {
                sv.removeFromSuperview()
            }
        }
    }
    
    private static let kLayerNameGradientBorder = "GradientBorderLayer"
        private static let kLayerNameBackgroundLayer = "BackgroundLayer"

        func gradientBorder(width: CGFloat,
                            colors: [UIColor],
                            startPoint: CGPoint = CGPoint(x: 1.0, y: 0.0),
                            endPoint: CGPoint = CGPoint(x: 1.0, y: 1.0),
                            andRoundCornersWithRadius cornerRadius: CGFloat = 0,
                            bgColor: UIColor = .clear,
                            shadowColor: UIColor = .black,
                            shadowRadius: CGFloat = 5.0,
                            shadowOpacity: Float = 0.75,
                            shadowOffset: CGSize = CGSize(width: 0.0, height: 0.0)
                            ) {
            
            let existingBackground = backgroundLayer()
            let bgLayer = existingBackground ?? CALayer()
            
            bgLayer.name = UIView.kLayerNameBackgroundLayer

            // set its color
            bgLayer.backgroundColor = bgColor.cgColor
            
            // insert at 0 to not cover other layers
            if existingBackground == nil {
                layer.insertSublayer(bgLayer, at: 0)
            }

            // use same cornerRadius as border
            bgLayer.cornerRadius = cornerRadius
            // inset its frame by 1/2 the border width
            bgLayer.frame = bounds.insetBy(dx: width * 0.5, dy: width * 0.5)

            // set shadow properties
            layer.shadowColor = shadowColor.cgColor
            layer.shadowRadius = shadowRadius
            layer.shadowOpacity = shadowOpacity
            layer.shadowOffset = shadowOffset

            let existingBorder = gradientBorderLayer()
            let border = existingBorder ?? CAGradientLayer()
            
            border.name = UIView.kLayerNameGradientBorder
            
            // don't do this
    //      border.frame = CGRect(x: bounds.origin.x, y: bounds.origin.y,
    //                            width: bounds.size.width + width, height: bounds.size.height + width)

            // use this instead
            border.frame = bounds

            border.colors = colors.map { $0.cgColor }
            border.startPoint = startPoint
            border.endPoint = endPoint
            
            let mask = CAShapeLayer()
            let maskRect = CGRect(x: bounds.origin.x + width/2, y: bounds.origin.y + width/2,
                                  width: bounds.size.width - width, height: bounds.size.height - width)
            
            let path = UIBezierPath(roundedRect: maskRect, cornerRadius: cornerRadius).cgPath
            mask.path = path
            mask.fillColor = UIColor.clear.cgColor
            mask.strokeColor = UIColor.black.cgColor
            mask.backgroundColor = UIColor.black.cgColor
            mask.lineWidth = width
            mask.masksToBounds = false
            border.mask = mask
            
            let exists = (existingBorder != nil)
            if !exists {
                layer.addSublayer(border)
            }
            
        }

        private func backgroundLayer() -> CALayer? {
            let aLayers = layer.sublayers?.filter { return $0.name == UIView.kLayerNameBackgroundLayer }
            if aLayers?.count ?? 0 > 1 {
                fatalError()
            }
            return aLayers?.first
        }

        private func gradientBorderLayer() -> CAGradientLayer? {
            let borderLayers = layer.sublayers?.filter { return $0.name == UIView.kLayerNameGradientBorder }
            if borderLayers?.count ?? 0 > 1 {
                fatalError()
            }
            return borderLayers?.first as? CAGradientLayer
        }
    
}



var hasTopNotch: Bool {
    if #available(iOS 11.0, tvOS 11.0, *) {
        return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
    }
    return false
}

class VDUtils {
    class func getThumbnailImage(forUrl url: URL) -> UIImage? {
        let asset: AVAsset = AVAsset(url: url)
        let assetImgGenerate = AVAssetImageGenerator(asset: asset)
        assetImgGenerate.appliesPreferredTrackTransform = true
        let time = CMTimeMakeWithSeconds(8.0, preferredTimescale: 1)
        do {
            let img = try assetImgGenerate.copyCGImage(at: time, actualTime: nil)
            let thumbnail = UIImage(cgImage: img)
            return thumbnail
        } catch {
          plog(error.localizedDescription)
        }
        return nil
    }
    class func jsonString(dict: [String: Any]) -> String?{
        
        var jsonString: String?
        
               do {
                   // Convert object to JSON as NSData
                   let jsonData = try JSONSerialization.data(withJSONObject: dict, options: [])
                   jsonString = String(data: jsonData, encoding: .utf8)
               } catch {
                   plog("error writing JSON: \(error)")
               }
        return jsonString
    }
}

//MARK: - Gradiant -
@IBDesignable
public class Gradient: UIView {
    @IBInspectable var startColor:   UIColor = .black { didSet { updateColors() }}
    @IBInspectable var endColor:     UIColor = .white { didSet { updateColors() }}
    @IBInspectable var startLocation: Double =   0.05 { didSet { updateLocations() }}
    @IBInspectable var endLocation:   Double =   0.95 { didSet { updateLocations() }}
    @IBInspectable var horizontalMode:  Bool =  false { didSet { updatePoints() }}
    @IBInspectable var diagonalMode:    Bool =  false { didSet { updatePoints() }}

    override public class var layerClass: AnyClass { CAGradientLayer.self }

    var gradientLayer: CAGradientLayer { layer as! CAGradientLayer }

    func updatePoints() {
        if horizontalMode {
            gradientLayer.startPoint = diagonalMode ? .init(x: 1, y: 0) : .init(x: 0, y: 0.5)
            gradientLayer.endPoint   = diagonalMode ? .init(x: 0, y: 1) : .init(x: 1, y: 0.5)
        } else {
            gradientLayer.startPoint = diagonalMode ? .init(x: 0, y: 0) : .init(x: 0.5, y: 0)
            gradientLayer.endPoint   = diagonalMode ? .init(x: 1, y: 1) : .init(x: 0.5, y: 1)
        }
    }
    func updateLocations() {
        gradientLayer.locations = [startLocation as NSNumber, endLocation as NSNumber]
    }
    func updateColors() {
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    }
    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updatePoints()
        updateLocations()
        updateColors()
    }

}
extension UILabel {
    func setHTML(html: String) {
        do{
//            let str = try NSAttributedString(data:html.data(using: .utf8, allowLossyConversion: true
//            )!, options:[NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html, NSAttributedString.DocumentReadingOptionKey.characterEncoding: NSNumber(unsignedLong: String.Encoding.utf8.rawValue)], documentAttributes: nil)
            let attributedString = try NSAttributedString(data: html.data(using: .utf8)!, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
            self.text =  attributedString.string
               } catch
               {
                   print("html error\n",error)
               }
            self.text = html
    }
}
