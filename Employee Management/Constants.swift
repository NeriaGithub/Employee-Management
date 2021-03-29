//
//  Constants.swift
//  Employee Management
//
//  Created by Neria Jerafi on 09/03/2021.
//

import Foundation

struct Constants {
    
    struct SegueId {
        static let employeeListSegue = "employeeListSegue"
        static let managementSegue = "managementSegue"
        static let emptyStateSegue = "emptyStateSegue"
        static let addEditSegue = "add/EditSegue"
    }
    
    struct Firebase {
        static let  collection = "employees"
        static let employeeListKey = "employeeList"
    }
    
    struct ErrorString {
        static let nonExistentUser = "The non-existent user needs to register first"
        static let inValidPasswordOrEmail = "The email or password is incorrect"
        static let couldNotReadData = "The data could not be displayed"
        static let detailsIsNotValid = "The details is not Valid"
    }
    
}
