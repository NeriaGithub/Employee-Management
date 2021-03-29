//
//  FirebaseManager.swift
//  Employee Management
//
//  Created by Neria Jerafi on 11/03/2021.
//

import Foundation
import Firebase


enum FirebaseError:Error {
    case failed
}
enum FirebaseSuccess:String {
    case ok = "Successful"
}

class FirebaseManager {
    private(set) var authentication:Auth?
    private(set) var db:Firestore?
    private var documentKey:String = ""
    
    init() {
        initialize()
    }
    
    private func initialize() {
        authentication = Auth.auth()
        db = Firestore.firestore()
        documentKey = authentication?.currentUser?.email ?? ""
        
    }
    
    func createUser(email:String, password:String, completion:@escaping(String)->()){
        authentication?.createUser(withEmail: email, password: password) {  (authResult, error) in
            if let error = error{
                completion(error.localizedDescription)
            }else{
                completion(FirebaseSuccess.ok.rawValue)
            }
        }
    }
    func loginUser(email:String, password:String, completion:@escaping(String)->()){
        authentication?.signIn(withEmail: email, password: password) { (authResult,  error) in
            if let error = error{
                completion(error.localizedDescription)
                
            }else{
                completion(FirebaseSuccess.ok.rawValue)
            }
        }
    }
    
     func documentExist(completion:@escaping(Bool)->())  {
        db?.collection(Constants.Firebase.collection).document(documentKey).getDocument(completion: { (snapshot, error) in
            if let document = snapshot , document.exists{
                DataManager.shared.documentExist = document.exists
                completion(true)
            }else{
                completion(false)
            }
        })
    }

    func createEmployee(employee:[String:String],completion:@escaping(String)->()) {
        db?.collection(Constants.Firebase.collection).document(documentKey).setData([Constants.Firebase.employeeListKey:[employee]], merge: true, completion: { (error) in
                if let error = error{
                    completion(error.localizedDescription)
                }else{
                    DataManager.shared.documentExist = true
                    completion(FirebaseSuccess.ok.rawValue)
                }
            })
        
    }
    
    func addEmployee(employee:[String:String],completion:@escaping(String)->()) {
        db?.collection(Constants.Firebase.collection).document(documentKey).updateData([Constants.Firebase.employeeListKey:FieldValue.arrayUnion([employee])], completion: { (error) in
            if let error = error{
                completion(error.localizedDescription)
            }else{
                completion(FirebaseSuccess.ok.rawValue)
            }
        })
    }
    
    func update(employeeList:[[String:String]], completion:@escaping(String)->())  {
        db?.collection(Constants.Firebase.collection).document(documentKey).setData([Constants.Firebase.employeeListKey:employeeList], merge: true, completion: { (error) in
                if let error = error{
                    completion(error.localizedDescription)
                }else{
                    completion(FirebaseSuccess.ok.rawValue)
                }
            })
    }
    
    func readEmployee(completion:@escaping(Result<FirebaseSuccess,FirebaseError>)->()) {
        db?.collection(Constants.Firebase.collection).document(documentKey).getDocument(completion: { (document, error) in
                if let data = document?.data()?[Constants.Firebase.employeeListKey] as? [[String:String]]{
                    for item in data {
                        do {
                            let employee = try Employee(dictionary: item)
                            DataManager.shared.employeeList.append(employee)
                        } catch  {
                            completion(.failure(.failed))
                        }
                    }
                    completion(.success(FirebaseSuccess.ok))
                }else{
                    completion(.failure(.failed))
                }
            })
    }
    func deleteEmployee(employee:[String:Any],completion:@escaping(Bool)->())  {
            db?.collection(Constants.Firebase.collection).document(documentKey).updateData([Constants.Firebase.employeeListKey:FieldValue.arrayRemove([employee])]) { (error) in
                if let _ = error{
                    completion(false)
                }else{
                    completion(true)
                }
            }
    }
}
