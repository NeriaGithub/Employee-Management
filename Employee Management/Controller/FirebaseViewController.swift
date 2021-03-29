//
//  FirebaseViewController.swift
//  Employee Management
//
//  Created by Neria Jerafi on 11/03/2021.
//

import UIKit

class FirebaseViewController: UIViewController {

    private(set) var firebaseManager:FirebaseManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firebaseManager = FirebaseManager()
    }
    

    

}
