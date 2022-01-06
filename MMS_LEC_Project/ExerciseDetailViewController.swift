//
//  ExerciseDetailViewController.swift
//  MMS_LEC_Project
//
//  Created by Septatrivanto Wandy on 22/12/21.
//  Copyright © 2021 Septatrivanto Wandy. All rights reserved.
//

import UIKit

class ExerciseDetailViewController: UIViewController, UITextFieldDelegate {

    // testing passes
    
    @IBOutlet weak var lblExerciseName: UILabel!
    @IBOutlet weak var tfExerciseRepetition: UITextField!
    @IBOutlet weak var lblExerciseNameWarning: UILabel!
    @IBOutlet weak var lblNumsRepetition: UILabel!
    @IBOutlet weak var lblNumsCal: UILabel!
    
    
    var exerciseName: String?
    var exerciseId: Int?
    var exerciseImage: String?
    var burnCalories: Float?
    var repetition: Int?
    var str: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tfExerciseRepetition.delegate = self
        
        lblExerciseName.text! = "\(exerciseName!)"
        lblExerciseNameWarning.text! = "\(exerciseName!)"
    }
    

    @IBAction func btnCalculate(_ sender: Any) {
        if (tfExerciseRepetition.text!.isEmpty){
            alert(msg: "input must not be empty", handler: nil)
        }
        else if(tfExerciseRepetition.text! == "0" || tfExerciseRepetition.text!.prefix(1) == "0") {
            alert(msg: "number invalid", handler: nil)
        }
        else{
            checkExercise()
        }
    }
    
    @IBAction func btnSaveHistory(_ sender: Any) {
        if (lblNumsCal.text! == "0"){
            alert(msg: "number invalid", handler: nil)
        }
        else {
            performSegue(withIdentifier: "backToHistoryVCInsertHistory", sender: self)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowChars = "0123456789"
        let allowCharSet = CharacterSet(charactersIn: allowChars)
        let typeCharSet = CharacterSet(charactersIn: string)
        return allowCharSet.isSuperset(of: typeCharSet);
    }
    
    func calculate(nominal: Float) {
        burnCalories = 0
        repetition = Int (tfExerciseRepetition.text!)
        burnCalories = Float (repetition!) * nominal
        
        lblNumsRepetition.text! = "\(repetition!)"
        lblNumsCal.text! = "\(burnCalories!)"
    }
    
    func checkExercise() {
        if(exerciseName == "Push Up"){
            calculate(nominal: 0.45)
        }
        else if(exerciseName == "Sit Up"){
            calculate(nominal: 0.2)
        }
        else if(exerciseName == "Hip Raise"){
            calculate(nominal: 0.5)
        }
        else if(exerciseName == "Leg Raise"){
            calculate(nominal: 0.5)
        }

        else if(exerciseName == "Burpees"){
            calculate(nominal: 0.5)
        }

        else if(exerciseName == "Jumping Jack"){
            calculate(nominal: 0.2)
        }

        else if(exerciseName == "Squats"){
            calculate(nominal: 0.2)
        }
        else if(exerciseName == "Lunges"){
            calculate(nominal: 0.2)
        }
    }
    
    func alert(msg:String, handler:((UIAlertAction)->Void)?) {
        let alert = UIAlertController(title: "Alert", message: msg, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
            
        alert.addAction(dismissAction)
        present(alert, animated: true, completion: nil)
    }

}
