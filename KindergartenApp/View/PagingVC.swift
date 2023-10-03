//
//  PagingVC.swift
//  KindergartenApp
//
//  Created by 김도훈 on 2023/10/03.
//

import Foundation
import UIKit

class PagingVC: UIViewController {
    
    var selectedKindergarten: KinderInfo?
    
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var recruitmentLabel: UILabel!
    @IBOutlet weak var peopleLabel: UILabel!
    
    @IBOutlet weak var classCount: UILabel!
    @IBOutlet weak var recruitmentCount: UILabel!
    @IBOutlet weak var peopleCount: UILabel!
    
    var index: Int = 0

    init?(coder: NSCoder, index: Int) {
        super.init(coder: coder)
//        self.explainList = explainList
        self.index = index
        print(#fileID, #function, #line, "- ")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        print(#fileID, #function, #line, "- ")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#fileID, #function, #line, "- ")
//        classLabel.text = explainList[0][0]
//        recruitmentLabel.text = explainList[0][1]
//        peopleLabel.text = explainList[0][2]
//
//        classCount.text = selectedKindergarten?.clcnt3
//        recruitmentCount.text = selectedKindergarten?.ag3fpcnt
//        peopleCount.text = selectedKindergarten?.ppcnt3
        
        classLabel.text = "index: \(index)"
    }
    
}

//MARK: - Helpers
extension PagingVC {
    
    class func getInstance(index: Int) -> PagingVC {
        
        let storyboard = UIStoryboard(name: "PagingVC", bundle: nil)
        let newPagingVC =  storyboard.instantiateInitialViewController(creator: { nsCoder in
            return PagingVC(coder: nsCoder, index: index)
        })!
        return newPagingVC
    }
    
}
