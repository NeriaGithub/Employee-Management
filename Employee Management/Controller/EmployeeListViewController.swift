//
//  EmployeeListViewController.swift
//  Employee Management
//
//  Created by Neria Jerafi on 09/03/2021.
//

import UIKit




class EmployeeListViewController: FirebaseViewController {
    
    @IBOutlet weak var employeeListTableView: UITableView!{
        didSet{
            employeeListTableView.estimatedRowHeight = 40
            employeeListTableView.rowHeight = UITableView.automaticDimension
            employeeListTableView.tableFooterView = UIView(frame: .zero)
            employeeListTableView.dataSource = self
            employeeListTableView.register(EmployeeCell.nib(), forCellReuseIdentifier: EmployeeCell.identifier)
        }
    }

    var selectedEmployee:Employee?
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configuration()
    }
    
    func reloadData() {
        if DataManager.shared.employeeListIsEmpty() {
            firebaseManager?.readEmployee(completion: { [weak self] (result) in
                guard let strongSelf = self else { return}
                switch result {
                case .failure(_):
                    print("alert error")
                case .success(_):
                    strongSelf.employeeListTableView.reloadData()
                }
            })
        }else{
            employeeListTableView.reloadData()
        }
    }
    
    func configuration() {
        if DataManager.shared.documentExist {
            (self.navigationController as? CustomNavigationViewController)?.backDelegate = self
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! AddEmployeeViewController
        destinationVC.delegate = self
        destinationVC.selectedEmployee = selectedEmployee
        
        
    }
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: Constants.SegueId.addEditSegue, sender: self)
    }
}




extension EmployeeListViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.shared.employeeList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EmployeeCell.identifier, for: indexPath) as!
            EmployeeCell
        cell.delegate = self
        cell.config()
        cell.employee = DataManager.shared.employeeList[indexPath.row]
        return cell
    }
}

extension EmployeeListViewController:EmployeeCellDelegate{
    func toggle(withCell cell:EmployeeCell) {
        UIView.animate(withDuration: 0.3) {
            self.employeeListTableView.beginUpdates()
            cell.isExpanded = !cell.isExpanded
            let image = cell.isExpanded ? UIImage(systemName: "chevron.up") : UIImage(systemName: "chevron.down")
            cell.toggleButton.setImage(image, for: .normal)
            self.employeeListTableView.endUpdates()
        }
    }
    
    func delete(withEmployee employee: Employee?) {
        guard let unwrappedEmployee = employee else {return}
        DataManager.shared.deleteEmployee(withEmployee: unwrappedEmployee)
        employeeListTableView.reloadData()
        firebaseManager?.deleteEmployee(employee: unwrappedEmployee.employeeDictionary, completion: { (Succeed) in
        })
    }
    
    func edit(withEmployee employee: Employee?) {
        guard let unwrappedEmployee = employee else {return}
        selectedEmployee = unwrappedEmployee
        performSegue(withIdentifier: Constants.SegueId.addEditSegue, sender: self)
    }
}

extension EmployeeListViewController: AddEmployeeViewControllerDelegate{
    func update() {
        employeeListTableView.reloadData()
        selectedEmployee = nil
    }
    
    
}

extension EmployeeListViewController:CustomNavigationViewControllerDelegate{
    func shouldPop() -> Bool {
        navigationController?.popToRootViewController(animated: true)
        return false
    }
}



