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
    var burnCalories: Double?
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
            alert(msg: "input must not be empty!", handler: nil)
        }
        else if(tfExerciseRepetition.text! == "0" || tfExerciseRepetition.text!.prefix(1) == "0") {
            alert(msg: "number invalid", handler: nil)
        }
        else{
            if(exerciseName == "Push Up"){
                burnCalories = 0
                repetition = Int (tfExerciseRepetition.text!)
                burnCalories = Double (repetition!) * 0.45
                
                lblNumsRepetition.text! = "\(repetition!)"
                lblNumsCal.text! = "\(burnCalories!)"
            }
            else if(exerciseName == "Sit Up"){
                burnCalories = 0
                repetition = Int (tfExerciseRepetition.text!)
                burnCalories = Double (repetition!) * 0.2
                
                lblNumsRepetition.text! = "\(repetition!)"
                lblNumsCal.text! = "\(burnCalories!)"
            }
            else if(exerciseName == "Hip Raise"){
                burnCalories = 0
                repetition = Int (tfExerciseRepetition.text!)
                burnCalories = Double (repetition!) * 0.5
                
                lblNumsRepetition.text! = "\(repetition!)"
                lblNumsCal.text! = "\(burnCalories!)"
            }
            else if(exerciseName == "Leg Raise"){
                burnCalories = 0
                repetition = Int (tfExerciseRepetition.text!)
                burnCalories = Double (repetition!) * 0.5
                
                lblNumsRepetition.text! = "\(repetition!)"
                lblNumsCal.text! = "\(burnCalories!)"
            }

            else if(exerciseName == "Burpees"){
                burnCalories = 0
                repetition = Int (tfExerciseRepetition.text!)
                burnCalories = Double (repetition!) * 0.5
                
                lblNumsRepetition.text! = "\(repetition!)"
                lblNumsCal.text! = "\(burnCalories!)"
            }

            else if(exerciseName == "Jumping Jack"){
                burnCalories = 0
                repetition = Int (tfExerciseRepetition.text!)
                burnCalories = Double (repetition!) * 0.2
                
                lblNumsRepetition.text! = "\(repetition!)"
                lblNumsCal.text! = "\(burnCalories!)"
            }

            else if(exerciseName == "Squats"){
                burnCalories = 0
                repetition = Int (tfExerciseRepetition.text!)
                burnCalories = Double (repetition!) * 0.2
                
                lblNumsRepetition.text! = "\(repetition!)"
                lblNumsCal.text! = "\(burnCalories!)"
            }

            else if(exerciseName == "Lunges"){
                burnCalories = 0
                repetition = Int (tfExerciseRepetition.text!)
                burnCalories = Double (repetition!) * 0.2
                
                lblNumsRepetition.text! = "\(repetition!)"
                lblNumsCal.text! = "\(burnCalories!)"
            }

        }
    }
    
    @IBAction func btnSaveHistory(_ sender: Any) {
        performSegue(withIdentifier: "backToHistoryVCInsertHistory", sender: self)
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

}
