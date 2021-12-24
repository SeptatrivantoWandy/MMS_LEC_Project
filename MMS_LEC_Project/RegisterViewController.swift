//
//  RegisterViewController.swift
//  MMS_LEC_Project
//
//  Created by Septatrivanto Wandy on 22/12/21.
//  Copyright © 2021 Septatrivanto Wandy. All rights reserved.
//

import UIKit
import CoreData

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var tfUserName: UITextField!
    @IBOutlet weak var tfUserEmail: UITextField!
    @IBOutlet weak var tfUserHeight: UITextField!
    @IBOutlet weak var tfUserWeight: UITextField!
    @IBOutlet weak var tfUserPassword: UITextField!
    @IBOutlet weak var tfUserConfirmPassword: UITextField!
    
    var userGender: String?
    var userList = [User]()
    var context:NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let appDelegate = UIApplication.shared.delegate.self as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        
        tfUserHeight.delegate = self
        tfUserWeight.delegate = self
        tfUserPassword.textContentType = .oneTimeCode
        tfUserConfirmPassword.textContentType = .oneTimeCode
        userGender = "Male"
        
        loadData()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowChars = "0123456789"
        let allowCharSet = CharacterSet(charactersIn: allowChars)
        let typeCharSet = CharacterSet(charactersIn: string)
        return allowCharSet.isSuperset(of: typeCharSet);
    }
    
    func alert(msg:String, handler:((UIAlertAction)->Void)?) {
        let alert = UIAlertController(title: "Alert", message: msg, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
            
        alert.addAction(dismissAction)
        present(alert, animated: true, completion: nil)
    }
    
    func isValidEmail(emailInput:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailInput)
    }
    
    @IBAction func segmentUserGender(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            userGender = "Male"
        }
        else if sender.selectedSegmentIndex == 1 {
            userGender = "Female"
        }
    }
    
    @IBAction func btnRegister(_ sender: Any) {
        if (tfUserName.text!.count < 5) {
            alert(msg: "user name must be at least 5 charaters", handler: nil)
        }
        else if (checkRegister() == 1) {
            alert(msg: "Username has already taken", handler: nil)
        }
        else if (tfUserEmail.text!.isEmpty){
            alert(msg: "email address must not empty", handler: nil)
        }
        else if (isValidEmail(emailInput: tfUserEmail.text!) == false){
            alert(msg: "email address input invalid, please enter valid email address", handler: nil)
        }
        else if (tfUserHeight.text!.isEmpty){
            alert(msg: "height must not empty", handler: nil)
        }
        else if (tfUserHeight.text!.prefix(1) == "0"){
            alert(msg: "height input invalid", handler: nil)
        }
        else if (tfUserWeight.text!.isEmpty){
            alert(msg: "weight must not empty", handler: nil)
        }
        else if (tfUserWeight.text!.prefix(1) == "0"){
            alert(msg: "weight input invalid", handler: nil)
        }
        else if (tfUserPassword.text!.count < 8) {
            alert(msg: "password must be at least 8 charaters", handler: nil)
        }
        else if (tfUserPassword.text!.rangeOfCharacter(from: CharacterSet.decimalDigits) == nil || tfUserPassword.text!.rangeOfCharacter(from: CharacterSet.letters) == nil) {
            alert(msg: "password must contain alphanumeric", handler: nil)
        }
        else if (tfUserConfirmPassword.text! != tfUserPassword.text!) {
            alert(msg: "confirm password are not the same as password", handler: nil)
        }
        else{
            performSegue(withIdentifier: "backToViewController", sender: self)
        }
        
        
    }
    
    func checkRegister() -> Int {
        for data in userList{
            if (data.userName == tfUserName.text!) {
                return 1
            }
        }
        return -1
    }
    
    func loadData() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserEntity")
        
        do {
            let results = try context.fetch(request) as! [NSManagedObject]
            userList.removeAll()
            
            for data in results {
                let userId = data.value(forKey: "userId") as! Int
                let userName = data.value(forKey: "userName") as! String
                let userEmail = data.value(forKey: "userEmail") as! String
                let userGender = data.value(forKey: "userGender") as! String
                let userHeight = data.value(forKey: "userHeight") as! Int
                let userWeight = data.value(forKey: "userWeight") as! Int
                let userPassword = data.value(forKey: "userPassword") as! String
                
                userList.append(User(
                    userId: userId,
                    userName: userName,
                    userEmail: userEmail,
                    userGender: userGender,
                    userHeight: userHeight,
                    userWeight: userWeight,
                    userPassword: userPassword
                ))
            }
        } catch  {
            
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    

}
