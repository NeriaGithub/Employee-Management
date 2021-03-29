//
//  DesignableUITextField.swift
//  Employee Management
//
//  Created by Neria Jerafi on 09/03/2021.
//

import UIKit

@IBDesignable
class DesignableUITextField: UITextField {
    @IBInspectable var leftImage: UIImage? {
           didSet {
               updateView()
           }
       }
       
       @IBInspectable var leftPadding: CGFloat = 0 {
           didSet {
               updateView()
           }
       }
       
       @IBInspectable var rightImage: UIImage? {
           didSet {
               updateView()
           }
       }
       
       @IBInspectable var rightPadding: CGFloat = 0 {
           didSet {
               updateView()
           }
       }
       
       private var _isRightViewVisible: Bool = true
       var isRightViewVisible: Bool {
           get {
               return _isRightViewVisible
           }
           set {
               _isRightViewVisible = newValue
               updateView()
           }
       }
       
       func updateView() {
           setLeftImage()
           setRightImage()
           
           // Placeholder text color
           attributedPlaceholder = NSAttributedString(string: placeholder != nil ?
               placeholder! :
                                                        "", attributes:[NSAttributedString.Key.foregroundColor: tintColor ?? .clear])
       }
       
       func setLeftImage() {
           leftViewMode = UITextField.ViewMode.always
           var view: UIView
           
           if let image = leftImage {
               let imageView = UIImageView(frame: CGRect(x: leftPadding, y: 0, width: 20, height: 20))
               imageView.image = image
               // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
               imageView.tintColor = tintColor
               
               var width = imageView.frame.width + leftPadding
               
               if borderStyle == UITextField.BorderStyle.none || borderStyle == UITextField.BorderStyle.line {
                   width += 5
               }
               
               view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 20))
               view.addSubview(imageView)
           } else {
               view = UIView(frame: CGRect(x: 0, y: 0, width: leftPadding, height: 20))
           }
           
           leftView = view
       }
       
       func setRightImage() {
           rightViewMode = UITextField.ViewMode.always
           
           var view: UIView
           
           if let image = rightImage, isRightViewVisible {
               let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
               imageView.image = image
               // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
               imageView.tintColor = tintColor
               
               var width = imageView.frame.width + rightPadding
               
               if borderStyle == UITextField.BorderStyle.none || borderStyle == UITextField.BorderStyle.line {
                   width += 5
               }
               
               view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 20))
               view.addSubview(imageView)
               
           } else {
               view = UIView(frame: CGRect(x: 0, y: 0, width: rightPadding, height: 20))
           }
           
           rightView = view
       }
    
    @IBInspectable var cornerRadiusTextField: CGFloat = 0 {
           didSet {
               self.layer.cornerRadius = cornerRadius
           }
       }
}




extension DesignableUITextField{
    var isEmpty: Bool {
        if let text = self.text, text.count == 0 {
           return true
        }
        return false
    }
    enum TextFiledType {
        case email
        case password
        case name
        case birthday
        case contact
    }
    
    func changeTextFieldTintColor(isEmpty:Bool) {
        if  !isEmpty{
            self.leftImage = self.leftImage?.withRenderingMode(.alwaysTemplate)
        self.tintColor = UIColor(named: "BrandBlue")
        }else{
            self.leftImage = self.leftImage?.withRenderingMode(.alwaysTemplate)
            self.tintColor = UIColor(named: "EmptyGray")
        }
    }
    

    
    func setTextFieldProperties(byTextFieldType type:TextFiledType) {
        switch type {
        case .email:
            self.placeholder = "email"
            self.leftImage = UIImage(named: "email")
            self.keyboardType = .emailAddress
            self.returnKeyType = .next
        case .password:
            self.placeholder = "password"
            self.leftImage = UIImage(named: "password")
            self.isSecureTextEntry = true
            self.returnKeyType = .done
        case .name:
            self.placeholder = "name"
            self.leftImage = UIImage(named: "name")
            self.returnKeyType = .next
        case .birthday:
            self.placeholder = "birthday"
            self.leftImage = UIImage(named: "birthday")
            self.returnKeyType = .next
        case .contact:
            self.placeholder = "phone number"
            self.leftImage = UIImage(named: "phone")
            self.keyboardType = .numberPad
            self.returnKeyType = .done
        }
    }
}
