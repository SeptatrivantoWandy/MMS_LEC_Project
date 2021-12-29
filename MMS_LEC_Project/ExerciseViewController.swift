//
//  ExerciseViewController.swift
//  MMS_LEC_Project
//
//  Created by Septatrivanto Wandy on 22/12/21.
//  Copyright © 2021 Septatrivanto Wandy. All rights reserved.
//

import UIKit

class ExerciseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
