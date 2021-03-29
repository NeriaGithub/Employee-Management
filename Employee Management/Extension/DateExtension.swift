//
//  DateExtension.swift
//  Employee Management
//
//  Created by Neria Jerafi on 15/03/2021.
//

import Foundation

extension Date{
    enum DateFormat:String {
        case dayMonthYear = "dd/MM/yyyy"
        case hourMinutes = "HH:mm a"
    }
    
    func convertDateToString(withDateFormat dateFormat:DateFormat) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat.rawValue
       return formatter.string(from: self)
    }
    
    func convertDateFromString(withDateFormat dateFormat:DateFormat, dateString:String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat.rawValue
        return formatter.date(from: dateString)
    }
    
    func getRandomStartTime()->Date? {
        let hour = Int.random(in: 7...11)
        let minute = Int.random(in: 0..<60)
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute
        let userCalendar = Calendar(identifier: .gregorian)
        let randomTime = userCalendar.date(from: dateComponents)
        return randomTime
    }
    
    func getEndTime(hours:Int = 9)->Date? {
        let userCalendar = Calendar(identifier: .gregorian)
        let endTime = userCalendar.date(byAdding: .hour, value: 9, to:self)
        return endTime
    }
}



extension Encodable {

    var dictionaryFromObject: [String: String]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: String] }
    }

}

extension Array where Element: Encodable {
    func asDictionaryFromArray() -> [[String: String]] {
        var dict = [[String: String]]()

        _ = self.map {
            if let objectDict = $0.dictionaryFromObject {
                dict.append(objectDict)
            }
        }

        return dict
    }

}
