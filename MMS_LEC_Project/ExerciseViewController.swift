//
//  ExerciseViewController.swift
//  MMS_LEC_Project
//
//  Created by Septatrivanto Wandy on 22/12/21.
//  Copyright © 2021 Septatrivanto Wandy. All rights reserved.
//

import UIKit
import CoreData

class ExerciseViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var newHistoryId = 0

    @IBOutlet weak var tblExercise: UITableView!
    let defaults = UserDefaults.standard
    var userIdPass: Int?
    
    var exerciseList: [Exercise] = []
    var exerciseId: Int?
    var exerciseImage: String?
    var exerciseName: String?
    var exerciseRound: Int?
    var exerciseRest: Int?
    
    var historyList = [History]()
    var context:NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblExercise.delegate = self
        tblExercise.dataSource = self
        
        let appDelegate = UIApplication.shared.delegate.self as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        
        appendExercises()
        loadHistoryData()
        checkUserIdDefault()
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
    
    func checkUserIdDefault(){ //check ID yg di login dan dapatkan userIdPassnya
        if let user = defaults.dictionary(forKey:"user"){
            userIdPass = user["useridpass"] as! Int
        }
    }
    
    func loadHistoryData() { // load data ke array yang dibuat
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "HistoryEntity")
        
        do {
            let results = try context.fetch(request) as! [NSManagedObject]
            historyList.removeAll()
            
            for data in results {
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
        } catch  {
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exerciseList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let exercise = exerciseList[indexPath.row]
        let exerciseCell = tableView.dequeueReusableCell(withIdentifier: "ExerciseTableViewCell") as! ExerciseTableViewCell
        
        exerciseCell.imgExercise.image = UIImage(named: "\(exercise.exerciseImage!)")
        exerciseCell.lblExerciseName.text = "\(exercise.exerciseName!)"
        exerciseCell.lblExerciseRoundNominal.text = "\(exercise.exerciseRound!)"
        exerciseCell.lblExerciseRestNominal.text = "\(exercise.exerciseRest!)"
        
        return exerciseCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let exercise = exerciseList[indexPath.row]
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ExerciseDetailViewController") as? ExerciseDetailViewController{
            
            vc.exerciseName = exercise.exerciseName
            vc.exerciseId = exercise.exerciseId
            vc.exerciseImage = exercise.exerciseImage
            
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func unwindToExerciseViewControllerBack(_ unwindSegue: UIStoryboardSegue) {
        
        // Use data from the view controller which initiated the unwind segue
    }
    

    @IBAction func unwindToExerciseViewControllerInsertHistoryDB(_ unwindSegue: UIStoryboardSegue) {
        if let source = unwindSegue.source as? ExerciseDetailViewController {
            
            if (historyList.isEmpty) {
                newHistoryId = 0
            }
            else {
                let lastHistoryId = historyList[historyList.count - 1].historyId
                newHistoryId = lastHistoryId! + 1
            }
            
            let newExerciseId = source.exerciseId!
            let newUserId = userIdPass!
            let newHistoryImage = source.exerciseImage!
            let newHistoryName = source.exerciseName!
            let newHistoryRepetition = source.repetition!
            let newHistoryCaloriesBurn = source.burnCalories!
            
            let entity = NSEntityDescription.entity(forEntityName: "HistoryEntity", in: context)
            let newHistory = NSManagedObject(entity: entity!, insertInto: context)
            
            newHistory.setValue(newHistoryId, forKey: "historyId")
            newHistory
                .setValue(newUserId, forKey: "userId")
            newHistory.setValue(newExerciseId, forKey: "exerciseId")
            newHistory.setValue(newHistoryImage, forKey: "historyImage")
            newHistory.setValue(newHistoryName, forKey: "historyName")
            newHistory.setValue(newHistoryRepetition, forKey: "historyRepetition")
            newHistory.setValue(newHistoryCaloriesBurn, forKey: "historyCaloriesBurn")
            
            do {
                try context.save()
            } catch {
                
            }
            loadHistoryData()
            
//            print("HistoryListSize: \(historyList.count)")
//            for (index, element) in historyList.enumerated() {
//                print("historyId: \(element.historyId!)")
//                print("userId: \(element.userId!)")
//                print("exerciseId: \(element.exerciseId!)")
//                print("historyImage: \(element.historyImage!)")
//                print("historyName: \(element.historyName!)")
//                print("historyRepetition: \(element.historyRepetition!)")
//                print("historyCaloriesBurn: \(element.historyCaloriesBurn!)")
//                print(" ")
//
//            }
        }
    }
    
    // insert outlet table viewnya, import table view delegate, dll
    // buat semua variabel penampung sesuai dengan core databasenya
    // isi class Exercise sesuai dengan core database juga (contoh seperti class user dengan menggunakan struct)
    // buat array of exercise (nama: exerciseList)
    // deklarasikan dulu user defaultnya cth ada di profile viewController (func checkUserIdDefault)
    // karena static, isi dan append array exerciseListnya dengan diisi dengan 8 macam exercise (isi id mulai dari 0)
    // buat func table view yang wajib (number of row untuk set jumlah row, cell for row untuk set label + image, dan did select row at untuk push navigation ke exerciseDetailVC)
    // unwind segue: unwindToViewControllerBack untuk fungsi back dari detail
    
    
    
    

}
