//
//  HistoryViewController.swift
//  MMS_LEC_Project
//
//  Created by Septatrivanto Wandy on 22/12/21.
//  Copyright © 2021 Septatrivanto Wandy. All rights reserved.
//

import UIKit
import CoreData

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tblHistory: UITableView!
    @IBOutlet weak var lblTotalCaloriesNom: UILabel!
    let defaults = UserDefaults.standard
    var userIdPass: Int?
    
    
    var historyList = [History]()
    var exerciseList = [Exercise]()
    
    var historyListCorrespond = [History]()
    var historyId: Int?
    var userId: Int?
    var exerciseId: Int?
    var historyImage: String?
    var historyName: String?
    var historyRepitition: Int?
    var historyCaloriesBurned: Float?
    
    var totalHistoryCaloriesBurned: Float?
    
    var context:NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appendExercises()

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        
        tblHistory.delegate = self
        tblHistory.dataSource = self
        
        loadHistoryData()
        checkUserIdDefault()
        checkUserIdPass()

//        lblTotalCaloriesNom.text = String(format: "%.2f", totalHistoryCaloriesBurned!)
        
        // Do any additional setup after loading the view.
    }
    
    func checkUserIdDefault(){ //check ID yg di login dan dapatkan userIdPassnya
        if let user = defaults.dictionary(forKey:"user"){
            userIdPass = user["useridpass"] as! Int
        }
    }
    
    func loadHistoryData(){
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "HistoryEntity")
        
            do{
                let results = try context.fetch(request) as! [NSManagedObject]
                historyList.removeAll()

                for data in results{
                    let historyId = data.value(forKey: "historyId") as! Int
                    let userId = data.value(forKey: "userId") as! Int
                    let exerciseId = data.value(forKey: "exerciseId") as! Int
                    let historyImage = data.value(forKey: "historyImage") as! String
                    let historyName = data.value(forKey: "historyName") as! String
                    let historyRepetition = data.value(forKey: "historyRepetition") as! Int
                    let historyCaloriesBurn = data.value(forKey: "historyCaloriesBurn") as! Float

                    let loadHistory = History()

                    loadHistory.historyId = historyId
                    loadHistory.userId = userId
                    loadHistory.exerciseId = exerciseId
                    loadHistory.historyImage = historyImage
                    loadHistory.historyName = historyName
                    loadHistory.historyRepetition = historyRepetition
                    loadHistory.historyCaloriesBurn = historyCaloriesBurn

                    historyList.append(loadHistory)
                }
            } catch{
                
            }
        }
    
    func checkUserIdPass(){
        
        historyListCorrespond.removeAll()
        totalHistoryCaloriesBurned = 0
        
        for element in historyList{
            if(element.userId == userIdPass){
                let historyId = element.historyId
                let userId = element.userId
                let exerciseId = element.exerciseId
                let historyImage = element.historyImage
                let historyName = element.historyName
                let historyRepitition = element.historyRepetition
                let historyCaloriesBurn = element.historyCaloriesBurn
                
                totalHistoryCaloriesBurned = totalHistoryCaloriesBurned! + historyCaloriesBurn!
                
                let saveUserHistory = History()
                
                saveUserHistory.historyId = historyId
                saveUserHistory.userId = userId
                saveUserHistory.exerciseId = exerciseId
                saveUserHistory.historyImage = historyImage
                saveUserHistory.historyName = historyName
                saveUserHistory.historyRepetition = historyRepitition
                saveUserHistory.historyCaloriesBurn = historyCaloriesBurn
                historyListCorrespond.append(saveUserHistory)
            }
        }
        tblHistory.reloadData()
        lblTotalCaloriesNom.text = String(format: "%.2f", totalHistoryCaloriesBurned!)
    }
    
//    func countTotalCalBurned(Float: calBurned){
//
//    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete){
            deleteData(indexPath: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyListCorrespond.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = historyListCorrespond[indexPath.row]
        let historyCell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableViewCell") as! HistoryTableViewCell
        
        historyCell.imgHistory.image = UIImage(named: "\(data.historyImage!)")
        historyCell.lblHistoryName.text = "\(data.historyName!)"
        historyCell.lblHistoryRepititionNominal.text = "\(data.historyRepetition!)"
        historyCell.lblCalBurnedNominal.text = "\(data.historyCaloriesBurn!)"
        
        return historyCell
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadHistoryData()
        checkUserIdDefault()
        checkUserIdPass()
        
        self.tblHistory.reloadData()
    }
    
    func deleteData(indexPath: IndexPath){
        let toDeleteId = historyListCorrespond[indexPath.row].historyId
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "HistoryEntity")
        let predicate = NSPredicate(format: "historyId == %i", toDeleteId!)
        request.predicate = predicate
        
        do {
            let results = try context.fetch(request) as! [NSManagedObject]
            
            for data in results{
                context.delete(data)
            }
            
            try context.save()
            loadHistoryData()
            checkUserIdDefault()
            checkUserIdPass()
        } catch  {
            
        }
    }
    
    func appendExercises() {
        let exercise1 = Exercise()
        exercise1.exerciseId = 0
        exercise1.exerciseImage = "push-up"
        exercise1.exerciseName = "Push Up"
        exercise1.exerciseRound = 1
        exercise1.exerciseRest = 30
        exerciseList.append(exercise1)
        
        let exercise2 = Exercise()
        exercise2.exerciseId = 1
        exercise2.exerciseImage = "sit-up"
        exercise2.exerciseName = "Sit Up"
        exercise2.exerciseRound = 2
        exercise2.exerciseRest = 45
        exerciseList.append(exercise2)
        
        let exercise3 = Exercise()
        exercise3.exerciseId = 2
        exercise3.exerciseImage = "hip-raise"
        exercise3.exerciseName = "Hip Raise"
        exercise3.exerciseRound = 3
        exercise3.exerciseRest = 30
        exerciseList.append(exercise3)

        let exercise4 = Exercise()
        exercise4.exerciseId = 3
        exercise4.exerciseImage = "leg-raise"
        exercise4.exerciseName = "Leg Raise"
        exercise4.exerciseRound = 3
        exercise4.exerciseRest = 30
        exerciseList.append(exercise4)

        let exercise5 = Exercise()
        exercise5.exerciseId = 4
        exercise5.exerciseImage = "burpees"
        exercise5.exerciseName = "Burpees"
        exercise5.exerciseRound = 2
        exercise5.exerciseRest = 45
        exerciseList.append(exercise5)

        let exercise6 = Exercise()
        exercise6.exerciseId = 5
        exercise6.exerciseImage = "jumping-jack"
        exercise6.exerciseName = "Jumping Jack"
        exercise6.exerciseRound = 3
        exercise6.exerciseRest = 30
        exerciseList.append(exercise6)

        let exercise7 = Exercise()
        exercise7.exerciseId = 6
        exercise7.exerciseImage = "squats"
        exercise7.exerciseName = "Squats"
        exercise7.exerciseRound = 1
        exercise7.exerciseRest = 45
        exerciseList.append(exercise7)

        let exercise8 = Exercise()
        exercise8.exerciseId = 7
        exercise8.exerciseImage = "lunges"
        exercise8.exerciseName = "Lunges"
        exercise8.exerciseRound = 2
        exercise8.exerciseRest = 30
        exerciseList.append(exercise8)
    }
    
    // 1. insert outlet table view, import table view delegate dll cth: exerciseViewController
    
    // 2. insert outlet label yang menampilkan total calories
    
    // 3. buat semua variable penampung sesuai dengan table cell yg akan ditampilkan
    
    // 4. buat variable userDefault + fungsi checkUserIdDefault untuk menampung userId
    
    // 5. buatkan array historyList untuk menampung semua history dan array historyListCorrespond untuk menampung semua history berdasarkan userId yang sama
    
    // 6. import coreData
    
    // 7. ambil fungsi loadHistoryData beserta variable context lainnya cth: exerciseViewController (perhatikan juga yang ada di viewDidLoad)
    
    // 8. lakukan tambahan fungsi looping di loadHistoryData untuk melakukan looping historyList untuk memvalidasi userId yg sama, jika sama maka simpan ke historyListCorrespond
    
    // 9. isikan label" table view cell cth: exerciseViewController dan tampilkan list berdasarkan array historyListCorrespond
    
    // 10. buatkan fungsi deleteDB cth: ada di video: 	ulai dari 1:38:58 format: "historyId == %i", historyId! (cth juga mirip dengan unwindToProfileViewControllerUpdateDBUser di profileViewController tapi cukup banyak berbeda) (yang di delete adalah data dari historyList BUKAN historyListCorrespond)
    
    // 11. tambahkan fungsi table canEditRow dan EditingStyle: Delete cth: sama kyk uts atau di video juga ada
    
    // 12. buatkan fungsi mentotalkan jumlah kalori yang terbakar berdasarkan historyListCorrespond
    
    // 13. buatkan fungsi viewWillAppear untuk melakukan reload table dan reload setLabel total kalori + set label juga saat melakukan delete pada fungsi table editing style
    
    // 14. selesai lakukan test commit push

}
