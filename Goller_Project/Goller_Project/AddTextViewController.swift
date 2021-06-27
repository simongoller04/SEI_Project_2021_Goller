//
//  AddTextViewController.swift
//  Goller_Project
//
//  Created by Simon Goller on 26.06.21.
//

import UIKit

class AddTextViewController: UIViewController {
    
    var update: (() -> Void )?
    let userDefaults = UserDefaults.standard
    
    @IBOutlet weak var Textfield: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        if Textfield.text == "" {
            navigationController?.popViewController(animated: true)
        }

        else {
            var counter = userDefaults.value(forKey: "counter") as! Int
            userDefaults.set(Textfield.text, forKey: "ToDo\(counter)")
            counter += 1
            userDefaults.set(counter, forKey: "counter")
            
            update? ()
            navigationController?.popViewController(animated: true)
        }
    }
    
//    func randomWord () {
//
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
