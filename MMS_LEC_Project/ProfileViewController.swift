//
//  ProfileViewController.swift
//  MMS_LEC_Project
//
//  Created by Septatrivanto Wandy on 22/12/21.
//  Copyright © 2021 Septatrivanto Wandy. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblUserGender: UILabel!
    @IBOutlet weak var lblUserEmail: UILabel!
    @IBOutlet weak var lblUserHeight: UILabel!
    @IBOutlet weak var lblUserWeight: UILabel!
    
    let defaults = UserDefaults.standard
    var userIdPass: Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        checkUserIdDefault()
    }
    
    func checkUserIdDefault(){
        if let user = defaults.dictionary(forKey:"user"){
            userIdPass = user["useridpass"] as! Int
        }
        lblUserName.text = "\(userIdPass as! Int)"
    }
    
    
    @IBAction func goToViewController(_ sender: Any) {
        defaults.removeObject(forKey: "user")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func unwindToProfileViewControllerBack(_ unwindSegue: UIStoryboardSegue) {
        
    }

}
