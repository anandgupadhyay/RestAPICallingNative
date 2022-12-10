//
//  ViewController.swift
//  DBTest
//
//  Created by Anand Upadhyay on 22/11/22.
//

//https://medium.com/@imbilalhassan/saving-data-in-sqlite-db-in-ios-using-swift-4-76b743d3ce0e

import UIKit

class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource
{
    let cellReuseIdentifier = "cell"
        
        var db:DBHelper = DBHelper()
        
        var persons:[Person] = []
    
    @IBOutlet weak var tblUserList: UITableView!

    override func viewDidLoad() {
        tblUserList.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tblUserList.delegate = self
        tblUserList.dataSource = self
        
        //insert in Table
        let iso8601String = Date.now.ISO8601Format()
        db.insert(id: 1, name: "Bagira", surname: "Panther", dob: iso8601String, photo: "")
        //get person list
        persons = db.read()

        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

extension ViewController{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)!
                cell.textLabel?.text = "Name: " + persons[indexPath.row].name + ", " + "Surname: " + persons[indexPath.row].surname + "Dob: " + persons[indexPath.row].dob
            return cell
    }
}
