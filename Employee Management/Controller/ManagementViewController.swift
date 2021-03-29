//
//  ManagementViewController.swift
//  Employee Management
//
//  Created by Neria Jerafi on 09/03/2021.
//

import UIKit

class ManagementViewController: FirebaseViewController {
    //MARK:-Properties
    
    
    
    @IBOutlet weak var managementView: UIView!{
        didSet{
            managementView.createShadow()
            managementView.addBorder(.left, color: UIColor(named: "BrandBlue")!, thickness: 5.0)
        }
    }
    @IBOutlet weak var attendanceView: UIView!{
        didSet{
            attendanceView.createShadow()
                attendanceView.addBorder(.left, color: UIColor(named: "BrandBlue")!, thickness: 5.0)
        }
    }
   
    @IBOutlet weak var performanceView: UIView!{
        didSet{
            performanceView.createShadow()
                performanceView.addBorder(.left, color: UIColor(named: "BrandBlue")!, thickness: 5.0)
        }
    }
   
    @IBOutlet weak var reportsView: UIView!{
        didSet{
            reportsView.createShadow()
                reportsView.addBorder(.left, color: UIColor(named: "BrandBlue")!, thickness: 5.0)
        }
    }

    @IBOutlet weak var transparentView: UIView!
    @IBOutlet weak var menuLeadingConstraint: NSLayoutConstraint!
    var isOpen = false

    //MARK:-LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //MARK:- Button tag enum for perform segue
    private enum ButtonTag:Int {
        case management = 1
        case attendance = 2
        case performance = 3
        case reports = 4
    }
    
    
    
    
    //MARK:- IBActions
    @IBAction func buttonTapped(_ sender: UIButton) {
        switch sender.tag {
        case ButtonTag.management.rawValue:
            firebaseManager?.documentExist{[weak self] isExist in
                guard let strongSelf = self else { return }
                var segueId = ""
                segueId =   isExist ? Constants.SegueId.employeeListSegue : Constants.SegueId.emptyStateSegue
                
                    strongSelf.performSegue(withIdentifier: segueId, sender: self)
            }
        default:
            break;
        }
    }
    
    
    @IBAction func menuButtonTapped(_ sender: UIBarButtonItem) {
        // open or close slide menu
        if isOpen {
            menuLeadingConstraint.constant = -200
            transparentView.isHidden = true
        }else{
            menuLeadingConstraint.constant = 0
            transparentView.isHidden = false
        }
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn) {
            self.view.layoutIfNeeded()
        }
        isOpen = !isOpen
    }
}


