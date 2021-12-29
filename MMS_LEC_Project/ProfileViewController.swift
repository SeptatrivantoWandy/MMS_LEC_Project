//
//  ProfileViewController.swift
//  MMS_LEC_Project
//
//  Created by Septatrivanto Wandy on 22/12/21.
//  Copyright © 2021 Septatrivanto Wandy. All rights reserved.
//

import UIKit
import CoreData //wajib ada di VC manapun yg menggunakan codeData

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblUserGender: UILabel!
    @IBOutlet weak var lblUserEmail: UILabel!
    @IBOutlet weak var lblUserHeight: UILabel!
    @IBOutlet weak var lblUserWeight: UILabel!
    
    var userList = [User]() // buat array of User
    var context:NSManagedObjectContext! //isi dari context
    let defaults = UserDefaults.standard //isi dari defaults
    var userIdPass: Int? //penampung user Id yg di login
    
    // silahakan buat penampung var update data
    var newHeight = ""
    var newWeight = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let appDelegate = UIApplication.shared.delegate.self as! AppDelegate // buat app delegate dari core data
        context = appDelegate.persistentContainer.viewContext //buat konteksny sesuai dengan core data
        loadData()
        checkUserIdDefault()
    
        // baca data dan set text dari array yang sudah distore dari database berdasarkan userIdPass
        lblUserName.text = userList[userIdPass!].userName
        lblUserGender.text = userList[userIdPass!].userGender
        lblUserEmail.text = userList[userIdPass!].userEmail
        lblUserHeight.text = "\(userList[userIdPass!].userHeight)"
        lblUserWeight.text = "\(userList[userIdPass!].userWeight)"
    }
    
    func checkUserIdDefault(){ //check ID yg di login dan dapatkan userIdPassnya
        if let user = defaults.dictionary(forKey:"user"){
            userIdPass = user["useridpass"] as! Int
        }
    }
    
    func loadData() { //isi core data ke array setiap kali ada masuk ke VC
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
    
    // hapus default idnya jika melakukan log out
    @IBAction func goToViewController(_ sender: Any) {
        defaults.removeObject(forKey: "user")
    }
    
    
    @IBAction func unwindToProfileViewControllerBack(_ unwindSegue: UIStoryboardSegue) {
        
    }
    
    @IBAction func unwindToProfileViewControllerUpdateDBUser(_ unwindSegue: UIStoryboardSegue) {
        if let source = unwindSegue.source as? ProfileUpdateViewController {
            newHeight = source.tfHeight.text!
            newWeight = source.tfWeight.text!
            
            // ! masih ada masalah di update profile
            let req = NSFetchRequest<NSFetchRequestResult>(entityName: "UserEntity")
            let predicate = NSPredicate(format: "userId = %@", userIdPass!)
            req.predicate = predicate
            
            do{
                let result = try context.fetch(req) as! [NSManagedObject]
                print(userIdPass!)
                print(result)
                for data in result{
                    data.setValue(newHeight, forKey: "userHeight")
                    data.setValue(newWeight, forKey: "userWeight")
                }
                
                try context.save()
                loadData()
                
            } catch {
                
            }
        }
        
    }

}
