//
//  LoginRegisterViewController.swift
//  Employee Management
//
//  Created by Neria Jerafi on 08/03/2021.
//

import UIKit
import Firebase



class LoginRegisterViewController: FirebaseViewController {
    // MARK: - Properties
    @IBOutlet weak var emailTextField: DesignableUITextField!{
        didSet{
            emailTextField.setTextFieldProperties(byTextFieldType: .email)
            emailTextField.createShadow()
            emailTextField.text = "neria.jerafi@gmail.com"
            emailTextField.delegate = self
        }
    }
    @IBOutlet weak var passwordTextField: DesignableUITextField!{
        didSet{
            passwordTextField.setTextFieldProperties(byTextFieldType: .password)
            passwordTextField.createShadow()
            passwordTextField.text = "123456"
            passwordTextField.delegate = self
        }
    }
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    
    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
}
    
    // MARK: - check if text is valid method
    private func isValid() -> Bool {
        if !emailTextField.isEmpty && !passwordTextField.isEmpty{
            return true
        }else{
            return false
        }
    }
    // MARK:- Change views color when text Field is full
    private func setViewsColor(color:UIColor) {
            loginButton.backgroundColor = color
            registerButton.backgroundColor  = color
        emailTextField.leftImage = emailTextField.leftImage?.withRenderingMode(.alwaysTemplate)
        emailTextField.tintColor = color
        passwordTextField.leftImage =  passwordTextField.leftImage?.withRenderingMode(.alwaysTemplate)
        passwordTextField.tintColor = color
    }
    
    // MARK: - IBActions
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        if isValid() {
            firebaseManager?.createUser(email: emailTextField.text!, password: passwordTextField.text!) { [weak self](response) in
                guard let strongSelf = self else { return }
                if response == FirebaseSuccess.ok.rawValue{
                    strongSelf.performSegue(withIdentifier: Constants.SegueId.managementSegue, sender: self)
                }else{
                    // show alert popup
                    Alert.alert(withMessage: response, VC: strongSelf)
                }
            }
        } else {
            Alert.alert(withMessage: Constants.ErrorString.inValidPasswordOrEmail, VC: self)
        }
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        if isValid() {
            firebaseManager?.loginUser(email: emailTextField.text!, password: passwordTextField.text!) { [weak self](response) in
                guard let strongSelf = self else { return }
                
                if response == FirebaseSuccess.ok.rawValue{
                    strongSelf.performSegue(withIdentifier: Constants.SegueId.managementSegue, sender: self)
                }else{
                    // show alert popup
                    Alert.alert(withMessage: response, VC: strongSelf)
                }
            }
        } else {
            Alert.alert(withMessage: Constants.ErrorString.inValidPasswordOrEmail, VC: self)
        }
    }
    
   
 
    
    
    
}
    


// MARK: -  UITextField Delegate method
extension LoginRegisterViewController:UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField  {
            passwordTextField.becomeFirstResponder()
        }else if textField == passwordTextField  {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        isValid() ? setViewsColor(color: UIColor(named: "BrandBlue") ?? .clear) : setViewsColor(color: UIColor(named: "EmptyGray") ?? .clear)
        
        
//        if isValid() {
//            setViewsColor(color: UIColor(named: "BrandBlue") ?? .clear)
//        }else{
//            setViewsColor(color: UIColor(named: "EmptyGray") ?? .clear)
//        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
}

