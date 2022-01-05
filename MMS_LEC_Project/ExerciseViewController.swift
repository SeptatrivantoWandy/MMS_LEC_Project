//
//  ExerciseViewController.swift
//  MMS_LEC_Project
//
//  Created by Septatrivanto Wandy on 22/12/21.
//  Copyright © 2021 Septatrivanto Wandy. All rights reserved.
//

import UIKit

class ExerciseViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var tblExercise: UITableView!
    
    
    var exerciseList: [Exercise] = []
    var exerciseId: Int?
    var exerciseImage: String?
    var exerciseName: String?
    var exerciseRound: Int?
    var exerciseRest: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblExercise.delegate = self
        tblExercise.dataSource = self
        
        appendExercises()
        
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
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func unwindToExerciseViewControllerBack(_ unwindSegue: UIStoryboardSegue) {
        
        // Use data from the view controller which initiated the unwind segue
    }
    

    @IBAction func unwindToExerciseViewControllerInsertHistoryDB(_ unwindSegue: UIStoryboardSegue) {
        
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
