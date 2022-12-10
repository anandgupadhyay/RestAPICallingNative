//
//  Home.swift
//  Employee
//
//  Created by Anand on 9/12/22
//

import UIKit

class Home: UIViewController {

    @IBOutlet weak var m_tblViewEmpList: UITableView!
    @IBOutlet weak var m_navigationBar: UINavigationBar!
    var topTitle = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        m_navigationBar.topItem?.title = topTitle
        
        m_tblViewEmpList.delegate = self
        m_tblViewEmpList.dataSource = self
        m_tblViewEmpList.reloadData()
    }
    
    @IBAction func actionLogout(_ sender: UIBarButtonItem) {
        self.openAlert(title: "Logout", message: "Are you sure you want to logout?", alertStyle: .alert, actionTitles: ["Cancel","Logout"], actionStyles: [.cancel,.default], actions: [
            {_ in
                print("Cancel")
            },
            {_ in
                self.popVC()
            }
        ])
    }
}
extension Home:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = "Employee " + "\(indexPath.row)"
        return cell!
    }
}
