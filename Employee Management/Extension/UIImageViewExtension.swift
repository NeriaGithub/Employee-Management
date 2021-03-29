//
//  UIImageViewExtension.swift
//  Employee Management
//
//  Created by Neria Jerafi on 10/03/2021.
//

import UIKit

extension UIImageView{
    func maskCircle(image:UIImage, borderWidth:CGFloat = 0.0, borderColor:UIColor = .clear)  {
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.contentMode = .scaleAspectFit
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = false
        self.clipsToBounds = true
        self.image = image
    }
}
