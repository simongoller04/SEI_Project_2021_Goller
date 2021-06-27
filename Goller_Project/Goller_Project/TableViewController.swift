//
//  TableViewController.swift
//  Goller_Project
//
//  Created by Simon Goller on 26.06.21.
//
import UIKit

class TableViewController: UITableViewController {
    
    var userDefaults = UserDefaults.standard
    var data = [String]()
    let CELL_ID = "CELL_ID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        
        if !userDefaults.bool(forKey: "first") {
            userDefaults.set(true, forKey: "first")
            userDefaults.set(0, forKey: "counter")
        }
        
        addToData()
    }
    
    func addToData() {
        data.removeAll()
        
        let counter = userDefaults.value(forKey: "counter") as! Int
        
        for n in 0...counter {
            if let dataTask = userDefaults.string(forKey: "ToDo\(n)") {
                data.append (dataTask)
            }
        }
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL_ID", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    
    @IBAction func plusButtonTapped(_ sender: Any) {
        let VC = storyboard?.instantiateViewController(identifier: "AddTextVC") as! AddTextViewController
        VC.update = {DispatchQueue.main.async {
            self.addToData()
        }}
        navigationController?.pushViewController(VC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let counter = userDefaults.value(forKey: "counter") as! Int
            
            var newCounter = 0
            
            data.remove(at: indexPath.row)
            userDefaults.removeObject(forKey: "ToDo\(indexPath.row)")

            for n in 0...counter {

                // delete row
                if n != indexPath.row {
                    if let name = userDefaults.string(forKey: "ToDo\(n)") {
                        userDefaults.set(name, forKey: "ToDo\(newCounter)")
                        newCounter += 1
                    }
                }
            }
            userDefaults.set(newCounter, forKey: "counter")
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
