//
//  StringExtension.swift
//  Employee Management
//
//  Created by Neria Jerafi on 25/03/2021.
//

import Foundation

extension String{
    func randomString(ofLength length: Int = 4) -> String {
        let letters = "0123456789"
        var s = ""
        for _ in 0 ..< length {
            s.append(letters.randomElement()!)
        }
        return s
    }
}
