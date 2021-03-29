//
//  ViewExtension.swift
//  Employee Management
//
//  Created by Neria Jerafi on 09/03/2021.
//

import UIKit


extension UIView{
    func createShadow(radius:CGFloat = 12.0, opacity:Float = 1.0, color:UIColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))  {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = .zero
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
    }
    
    
    func createCornerRadius(radius:CGFloat) {
        self.layer.cornerRadius = radius
    }
    
    @IBInspectable var cornerRadius:CGFloat{
        get{
            return layer.cornerRadius
        }
        set{
            layer.cornerRadius = newValue
        }
    }
    
    func addBorder(_ edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
           let subview = UIView()
           subview.translatesAutoresizingMaskIntoConstraints = false
           subview.backgroundColor = color
           self.addSubview(subview)
           switch edge {
           case .top, .bottom:
               subview.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
               subview.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
               subview.heightAnchor.constraint(equalToConstant: thickness).isActive = true
               if edge == .top {
                   subview.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
               } else {
                   subview.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
               }
           case .left, .right:
               subview.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
               subview.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
               subview.widthAnchor.constraint(equalToConstant: thickness).isActive = true
               if edge == .left {
                   subview.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
               } else {
                   subview.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
               }
           default:
               break
           }
       }
   
}
