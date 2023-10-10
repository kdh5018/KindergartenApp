//
//  OldSpecialVC.swift
//  KindergartenApp
//
//  Created by 김도훈 on 2023/10/03.
//

import UIKit

class OldSpecialVC: UIViewController {
    
    var selectedKindergarten: KinderInfo?
    
    @IBOutlet weak var classSpecialCount: UILabel!
    @IBOutlet weak var recruitmentSpecialCount: UILabel!
    @IBOutlet weak var peopleSpecialCount: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.selectedKindergarten = DataController.shared.selectedKindergarten

        classSpecialCount.text = selectedKindergarten?.shclcnt
        recruitmentSpecialCount.text = selectedKindergarten?.spcnfpcnt
        peopleSpecialCount.text = selectedKindergarten?.shppcnt
    }

}
