//
//  Old3VC.swift
//  KindergartenApp
//
//  Created by 김도훈 on 2023/10/03.
//

import UIKit

class Old3VC: UIViewController {
    
    var selectedKindergarten: KinderInfo?
    
    @IBOutlet weak var class3Count: UILabel!
    @IBOutlet weak var recruitment3Count: UILabel!
    @IBOutlet weak var people3Count: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(#fileID, #function, #line, "- 3세selectedKindergarten: \(selectedKindergarten)")
        
        class3Count.text = selectedKindergarten?.clcnt3
        recruitment3Count.text = selectedKindergarten?.ag3fpcnt
        people3Count.text = selectedKindergarten?.ppcnt3
        
    }
    

}
