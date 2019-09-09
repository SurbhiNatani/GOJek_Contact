//
//  Extensions.swift
//  GJIOS
//
//  Created by Shurbhi Natani on 06/09/19.
//  Copyright © 2019 Surbhi Natani. All rights reserved.
//

import Foundation
import UIKit


extension UIViewController {
    func showErrorAlertWithTitle(_ title:String?, message:String) {
        
        let alertController = UIAlertController(title: title ?? "", message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (result : UIAlertAction) -> Void in
            
        }
        
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showSuccessAlertWithTitle(_ title:String?, message:String) {
        
        let alertController = UIAlertController(title: title ?? "", message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (result : UIAlertAction) -> Void in
            self.dismiss(animated: true, completion: {
                
            })
        }
        
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showProgressView(onWindow: Bool) {
        let frame = onWindow ? UIScreen.main.bounds : view.bounds
        let progressView = ProgressView(frame: frame, isScannedView: false)
        onWindow ? UIApplication.shared.keyWindow?.addSubview(progressView) : view.addSubview(progressView)
    }
    
    func hideProgressView() {
        if let progressView = view.subviews.first(where: { $0.isKind(of: ProgressView.self)}) {
            progressView.removeFromSuperview()
        } else if let progressView = UIApplication.shared.keyWindow?.subviews.first(where: { $0.isKind(of: ProgressView.self)})  {
            progressView.removeFromSuperview()
        }
    }
    
}

extension UIImageView{
  
    func downloadImageFrom(link:String, contentMode: UIView.ContentMode) {
        
        URLSession.shared.dataTask(with: URL(string: link)! , completionHandler: { (data, response, error) in
            
            DispatchQueue.main.async {
                self.contentMode =  contentMode
                if let data = data {
                    DispatchQueue.main.async {
                        self.image = UIImage(data: data)
                    }
                }
            }
        }).resume()

   }
    
}


extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}



extension  UIView{
    
    func addGradient(){
        let gradientLayer = CAGradientLayer.init()
        gradientLayer.colors = [UIColor.white, UIColor(rgb: 0x50E3C2).withAlphaComponent(0.4)].map({$0.cgColor})
        gradientLayer.type = .axial
        gradientLayer.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        gradientLayer.masksToBounds = true
        self.layer.insertSublayer(gradientLayer, at: 0)
        self.backgroundColor = UIColor.clear
    }
    
    func roundedBorders(radius: CGFloat, borderColor: UIColor = UIColor.clear, borderWidth: CGFloat = 0) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
    }
    
    func addblurEffect(atIndex: Int = 0) {
        let blurEffect = UIBlurEffect(style: .regular)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = bounds
        let vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: blurEffect))
        vibrancyView.frame = bounds
        blurView.contentView.addSubview(vibrancyView)
        backgroundColor = UIColor.clear
        insertSubview(blurView, at: 0)
        blurView.alpha = 0.9
    }
    
    func getShadow(radius: CGFloat, color: UIColor = UIColor.black.withAlphaComponent(0.5)) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: -5, height: 1)
        layer.shadowRadius = radius
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = true ? UIScreen.main.scale : 1
    }
    
    
}


extension String {
    var isValidEmail: Bool {
        let regularExpressionForEmail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let testEmail = NSPredicate(format:"SELF MATCHES %@", regularExpressionForEmail)
        return testEmail.evaluate(with: self)
    
    }
    var isValidPhone: Bool {
        
        if self.count < 10 {
            return false
        }

        var number = self

        number.insert("-", at: number.index(number.startIndex, offsetBy: 3))
        number.insert("-", at: number.index(number.startIndex, offsetBy: 7))

        let regex = "^\\d{3}-\\d{3}-\\d{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", regex)
        let result =  phoneTest.evaluate(with: number)
        return result
    }
}
