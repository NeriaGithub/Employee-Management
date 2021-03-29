//
//  Alert.swift
//  Employee Management
//
//  Created by Neria Jerafi on 25/03/2021.
//

import Foundation
import UIKit

class Alert {
    static func alert(withMessage message:String, VC:UIViewController ) {
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        VC.present(alert, animated: true, completion: nil)
    }
}
