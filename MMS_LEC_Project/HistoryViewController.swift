//
//  HistoryViewController.swift
//  MMS_LEC_Project
//
//  Created by Septatrivanto Wandy on 22/12/21.
//  Copyright © 2021 Septatrivanto Wandy. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    
    // 10. buatkan fungsi deleteDB cth: ada di video: https://drive.google.com/file/d/1ycSXL283EZMaGw_pHXJxR5xaGyIqRHN4/view?usp=sharing mulai dari 1:38:58 format: "historyId == %i", historyId! (cth juga mirip dengan unwindToProfileViewControllerUpdateDBUser di profileViewController tapi cukup banyak berbeda) (yang di delete adalah data dari historyList BUKAN historyListCorrespond)
    
    // 11. tambahkan fungsi table canEditRow dan EditingStyle: Delete cth: sama kyk uts atau di video juga ada
    
    // 12. buatkan fungsi mentotalkan jumlah kalori yang terbakar berdasarkan historyListCorrespond
    
    // 13. buatkan fungsi viewWillAppear untuk melakukan reload table dan reload setLabel total kalori + set label juga saat melakukan delete pada fungsi table editing style
    
    // 14. selesai lakukan test commit push

}
