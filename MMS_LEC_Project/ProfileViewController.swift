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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let appDelegate = UIApplication.shared.delegate.self as! AppDelegate // buat app delegate dari core data
        context = appDelegate.persistentContainer.viewContext //buat konteksny sesuai dengan core data
        loadData()
        checkUserIdDefault()
    
        // print(userIdPass!)
        // baca data dan set text dari array yang sudah distore dari database berdasarkan userIdPass
        lblUserName.text = userList[userIdPass!].userName
        lblUserGender.text = userList[userIdPass!].userGender
        lblUserEmail.text = userList[userIdPass!].userEmail
        lblUserHeight.text = "\(userList[userIdPass!].userHeight)"
        lblUserWeight.text = "\(userList[userIdPass!].userWeight)"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        lblUserHeight.text = "\(userList[userIdPass!].userHeight)"
        lblUserWeight.text = "\(userList[userIdPass!].userWeight)"
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToUpdateProfileSegue" {
            let navigation = segue.destination as! UINavigationController
            let destination = navigation.viewControllers.first as! ProfileUpdateViewController
            
            destination.loadUpdateHeight = userList[userIdPass!].userHeight
            destination.loadUpdateWeight = userList[userIdPass!].userWeight
            
        }
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
            let updateHeight = source.tfHeight.text!
            let updateWeight = source.tfWeight.text!
            
            
            let req = NSFetchRequest<NSFetchRequestResult>(entityName: "UserEntity")
            let predicate = NSPredicate(format: "userId == %i", userIdPass!)
            req.predicate = predicate
            
            do{
                let result = try context.fetch(req) as! [NSManagedObject]
//                print(userIdPass!)
//                print(result)
                for data in result{
//                    print(data.value(forKey: "userId") as! Int)
                    data.setValue(Int(updateHeight), forKey: "userHeight")
                    data.setValue(Int(updateWeight), forKey: "userWeight")
                }
                
                try context.save()
                loadData()
                
            } catch {
                
            }
        }
        
    }

}
