//
//  CustomNavigationViewController.swift
//  Employee Management
//
//  Created by Neria Jerafi on 14/03/2021.
//

import Foundation
import UIKit

protocol CustomNavigationViewControllerDelegate:class {
    func shouldPop() -> Bool
}

class CustomNavigationViewController: UINavigationController, UINavigationBarDelegate {
   weak var backDelegate: CustomNavigationViewControllerDelegate?

    func navigationBar(_ navigationBar: UINavigationBar, shouldPop item: UINavigationItem) -> Bool {
        return backDelegate?.shouldPop() ?? true
    }
}
