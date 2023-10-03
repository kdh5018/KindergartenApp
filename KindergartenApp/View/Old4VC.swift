//
//  Old4VC.swift
//  KindergartenApp
//
//  Created by 김도훈 on 2023/10/03.
//

import UIKit

class Old4VC: UIViewController {
    
    var selectedKindergarten: KinderInfo?
    
    @IBOutlet weak var class4Count: UILabel!
    @IBOutlet weak var recruitment4Count: UILabel!
    @IBOutlet weak var people4Count: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print(#fileID, #function, #line, "- 4세selectedKindergarten: \(selectedKindergarten)")

        class4Count.text = selectedKindergarten?.clcnt4
        recruitment4Count.text = selectedKindergarten?.ag4fpcnt
        people4Count.text = selectedKindergarten?.ppcnt4
        
    }

}
