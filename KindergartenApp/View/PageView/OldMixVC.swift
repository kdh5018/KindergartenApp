//
//  OldMixVC.swift
//  KindergartenApp
//
//  Created by 김도훈 on 2023/10/03.
//

import UIKit

class OldMixVC: UIViewController {
    
    var selectedKindergarten: KinderInfo?
    
    @IBOutlet weak var classMixCount: UILabel!
    @IBOutlet weak var recruitmentMixCount: UILabel!
    @IBOutlet weak var peopleMixCount: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.selectedKindergarten = DataController.shared.selectedKindergarten
        
        classMixCount.text = selectedKindergarten?.mixclcnt
        recruitmentMixCount.text = selectedKindergarten?.mixfpcnt
        peopleMixCount.text = selectedKindergarten?.mixppcnt
        
        
    }

}
