//
//  DataManager.swift
//  Employee Management
//
//  Created by Neria Jerafi on 14/03/2021.
//

import Foundation

class DataManager {
    var employeeList:[Employee] = []
    static let shared:DataManager = DataManager()
    var documentExist = false
    private init(){}
    
    func employeeListIsEmpty() -> Bool {
        return employeeList.isEmpty ? true : false
    }
    
    func deleteEmployee(withEmployee employee:Employee) {
        guard let index = employeeList.firstIndex(where: {$0.id == employee.id}) else { return}
        employeeList.remove(at: index)
    }
}
