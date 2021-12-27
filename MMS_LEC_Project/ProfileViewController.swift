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
        // tampung dulu variable yg di update dari profileUpdateVC cth ad di VC (unwindToViewControllerInsertDBUser)
        
        // mulai syntax insert
        
        // lihat video di: 1:54:40 kalau mau lihat asal mulanya lihat di: 1:38:8 kecuali untuk syntax self. tidak perlu. contohkah smpai ke try catch https://drive.google.com/file/d/1ycSXL283EZMaGw_pHXJxR5xaGyIqRHN4/view?usp=sharing
        
        
        
    }

}
