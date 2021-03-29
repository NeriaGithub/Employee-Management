//
//  Employee.swift
//  Employee Management
//
//  Created by Neria Jerafi on 08/03/2021.
//

import Foundation

struct Employee:Codable {
    let id:String
    var name:String
    var birthday:String
    var contact:String
    var employeeDictionary: [String:String] {
        return["name":name,
               "birthday":birthday,
               "contact":contact,
               "id":id]
    }
}

extension Employee{
    init(dictionary:[String:String]) throws {
        self = try JSONDecoder().decode(Employee.self, from: JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted))
    }
}
