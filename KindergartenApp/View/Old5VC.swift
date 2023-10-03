//
//  Old5VC.swift
//  KindergartenApp
//
//  Created by 김도훈 on 2023/10/03.
//

import UIKit

class Old5VC: UIViewController {
    
    var selectedKindergarten: KinderInfo?
    
    @IBOutlet weak var class5Count: UILabel!
    @IBOutlet weak var recruitment5Count: UILabel!
    @IBOutlet weak var people5Count: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        class5Count.text = selectedKindergarten?.clcnt5
        recruitment5Count.text = selectedKindergarten?.ag5fpcnt
        people5Count.text = selectedKindergarten?.ppcnt5
        
    }


}
