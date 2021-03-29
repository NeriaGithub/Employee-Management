//
//  EmployeeCell.swift
//  Employee Management
//
//  Created by Neria Jerafi on 18/03/2021.
//

import UIKit



protocol EmployeeCellDelegate:class {
    func toggle(withCell cell:EmployeeCell)
    func delete(withEmployee employee:Employee?)
    func edit(withEmployee employee:Employee?)
}

class EmployeeCell: UITableViewCell {
    
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var heightTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var inTimeLabel: UILabel!
    @IBOutlet weak var outTimeLabel: UILabel!
    @IBOutlet weak var toggleButton: UIButton!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var contactLabel: UILabel!

    weak var delegate:EmployeeCellDelegate?
    var employee: Employee? {
        didSet{
            if let unwrappedEmployee = employee {
                nameLabel.text = unwrappedEmployee.name
                birthdayLabel.text = employee?.birthday
                contactLabel.text = employee?.contact
                guard let startTime = Date().getRandomStartTime(),
                      let endTime = startTime.getEndTime() else {return}
                inTimeLabel.text = startTime.convertDateToString(withDateFormat: .hourMinutes)
                outTimeLabel.text = endTime.convertDateToString(withDateFormat: .hourMinutes)
            }
        }
    }
    var isExpanded: Bool = false {
        didSet{
            if !isExpanded {
                heightTopConstraint.constant = 0.0
            }else{
                heightTopConstraint.constant = 208.0
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        shadowView.createShadow(radius: 8.0, opacity: 0.4)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func config()  {
        isExpanded = false
        toggleButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
    }
    
    static let identifier = "EmployeeCell"
    static func nib()->UINib{
        return UINib(nibName: identifier, bundle: nil)
    }
   
    @IBAction func toggle(_ sender: UIButton) {
        delegate?.toggle(withCell: self)
    }
    
    
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        delegate?.delete(withEmployee: employee)
    }
    
    @IBAction func editButtonTapped(_ sender: UIButton) {
        delegate?.edit(withEmployee: employee)
    }
}
