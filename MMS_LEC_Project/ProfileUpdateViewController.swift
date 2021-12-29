//
//  ProfileUpdateViewController.swift
//  MMS_LEC_Project
//
//  Created by Septatrivanto Wandy on 22/12/21.
//  Copyright © 2021 Septatrivanto Wandy. All rights reserved.
//

import UIKit

class ProfileUpdateViewController: UIViewController {

    @IBOutlet weak var tfHeight: UITextField!
    @IBOutlet weak var tfWeight: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func alert(msg:String, handler:((UIAlertAction)->Void)?) {
        let alert = UIAlertController(title: "Alert", message: msg, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
            
        alert.addAction(dismissAction)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func btnSave(_ sender: Any) {
        if (tfHeight.text!.isEmpty) {
            alert(msg: "Height must be filled", handler: nil)
        }
        else if (tfWeight.text!.isEmpty){
            alert(msg: "Weight must be filled", handler: nil)
        }
        else {
            performSegue(withIdentifier: "backToProfileViewController", sender: self)
        }
    }
    

}
