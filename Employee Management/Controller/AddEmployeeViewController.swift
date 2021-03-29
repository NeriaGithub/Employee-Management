//
//  AddEmployeeViewController.swift
//  Employee Management
//
//  Created by Neria Jerafi on 14/03/2021.
//

import UIKit



protocol AddEmployeeViewControllerDelegate:class {
    func update()
}


class AddEmployeeViewController: FirebaseViewController {
    
    @IBOutlet weak var profileTextField: DesignableUITextField!{
        didSet{
            profileTextField.createShadow()
            profileTextField.setTextFieldProperties(byTextFieldType: .name)
            profileTextField.delegate = self
        }
    }
    @IBOutlet weak var birthdayTextField: DesignableUITextField!{
        didSet{
            birthdayTextField.createShadow()
            birthdayTextField.setTextFieldProperties(byTextFieldType: .birthday)
            birthdayTextField.delegate = self
        }
    }
    
    @IBOutlet weak var contactTextField: DesignableUITextField!{
        didSet{
            contactTextField.createShadow()
            contactTextField.setTextFieldProperties(byTextFieldType: .contact)
            contactTextField.delegate = self
        }
    }
    
    @IBOutlet weak var submitButton: UIButton!
    weak var delegate:AddEmployeeViewControllerDelegate?
    private var datePicker:UIDatePicker!
    var selectedEmployee:Employee?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
        if let unwrappedEmployee = selectedEmployee {
            profileTextField.text = unwrappedEmployee.name
            birthdayTextField.text = unwrappedEmployee.birthday
            contactTextField.text = unwrappedEmployee.contact
            //setViewsColor(color: UIColor(named: "BrandBlue") ?? .clear)
        }
        
    }
    
    func configuration() {
        createDatePicker()
        if DataManager.shared.documentExist {
            (self.navigationController as? CustomNavigationViewController)?.backDelegate = self
        }
    }
    
    private func createDatePicker() {
        // date picker configuration
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        // toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        // bar button
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneTapped))
        toolbar.setItems([doneButton], animated: true)
        // assign toolbar
        birthdayTextField.inputAccessoryView = toolbar
        //assign date picker to text field
        birthdayTextField.inputView = datePicker
        
    }
    
    @objc private func doneTapped(){
        birthdayTextField.text = datePicker.date.convertDateToString(withDateFormat: .dayMonthYear)
        self.view.endEditing(true)
    }
    
    
    private func isTextFieldsFull()->Bool{
        if !profileTextField.isEmpty && !birthdayTextField.isEmpty &&
            !contactTextField.isEmpty{
            return true
        }
        return false
    }
    
    
    private func setViewsColor(color:UIColor) {
        submitButton.backgroundColor = color
        profileTextField.leftImage = profileTextField.leftImage?.withRenderingMode(.alwaysTemplate)
        profileTextField.tintColor = color
        
        birthdayTextField.leftImage =  birthdayTextField.leftImage?.withRenderingMode(.alwaysTemplate)
        birthdayTextField.tintColor = color
        contactTextField.leftImage =  contactTextField.leftImage?.withRenderingMode(.alwaysTemplate)
        contactTextField.tintColor = color
    }
    
    private func isValidToSubmit() -> Bool {
        if !profileTextField.isEmpty && !birthdayTextField.isEmpty &&
            !contactTextField.isEmpty &&
            contactTextField.text?.count == 10{
            return true
        }else{
            return false
        }
    }
    
    func createEmployee() -> Employee {
        if selectedEmployee != nil {
            selectedEmployee?.name = profileTextField.text!
            selectedEmployee?.birthday = birthdayTextField.text!
            selectedEmployee?.contact = contactTextField.text!
            return selectedEmployee!
        }else{
            return Employee(id: String().randomString(), name: profileTextField.text!, birthday: birthdayTextField.text!, contact: contactTextField.text!)
        }
    }
    
    func saveToFirebase(){
        let employee = createEmployee()
        if DataManager.shared.documentExist{
            if let updateEmployee = selectedEmployee{
                guard let index = DataManager.shared.employeeList.firstIndex(where: {$0.id == updateEmployee.id}) else { return}
                DataManager.shared.employeeList[index] = updateEmployee
                firebaseManager?.update(employeeList: DataManager.shared.employeeList.asDictionaryFromArray()){ [weak self]
                    (msg) in
                    guard let strongSelf = self else { return}
                    if msg == FirebaseSuccess.ok.rawValue{
                        strongSelf.delegate?.update()
                        strongSelf.navigationController?.popViewController(animated: true)
                    }else{
                        Alert.alert(withMessage: msg, VC: strongSelf)
                    }
                        
                }
            }else{
                firebaseManager?.addEmployee(employee:employee.employeeDictionary){ [weak self] (msg) in
                    guard let strongSelf = self else { return}
                    if msg == FirebaseSuccess.ok.rawValue{
                        DataManager.shared.employeeList.append(employee)
                        strongSelf.delegate?.update()
                        strongSelf.navigationController?.popViewController(animated: true)
                    }else{
                        Alert.alert(withMessage: msg, VC: strongSelf)
                    }
                }
            }
        }else{
            firebaseManager?.createEmployee(employee: employee.employeeDictionary){ [weak self] msg in
                guard let strongSelf = self else { return}
                if msg == FirebaseSuccess.ok.rawValue{
                    let destinationVC = strongSelf.storyboard?.instantiateViewController(identifier: "EmployeeListViewController") as! EmployeeListViewController
                    strongSelf.navigationController?.pushViewController(destinationVC, animated: true)
                }else{
                    Alert.alert(withMessage: msg, VC: strongSelf)
                }
            }
        }
    }
    
    @IBAction func submitButtonTapped(_ sender: UIButton) {
        if isValidToSubmit() {
            saveToFirebase()
        }else{
            Alert.alert(withMessage: Constants.ErrorString.detailsIsNotValid, VC: self)
        }
    }
}

extension AddEmployeeViewController:UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == profileTextField  {
            birthdayTextField.becomeFirstResponder()
        }else if textField == birthdayTextField  {
            contactTextField.becomeFirstResponder()
        } else if textField == contactTextField{
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        isTextFieldsFull() ? self.setViewsColor(color: UIColor(named: "BrandBlue") ?? .clear) : self.setViewsColor(color: UIColor(named: "EmptyGray") ?? .clear)
    }
}

extension AddEmployeeViewController:CustomNavigationViewControllerDelegate{
    func shouldPop() -> Bool {
        navigationController?.popViewController(animated: true)
        return false
    }
}
