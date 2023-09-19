//
//  KindergartenCell.swift
//  KindergartenApp
//
//  Created by 김도훈 on 2023/09/05.
//

import UIKit

class KindergartenCell: UITableViewCell {
    
    @IBOutlet weak var kindergartenName: UILabel!
    @IBOutlet weak var kindergartenAddress: UILabel!
    @IBOutlet weak var kindergartenCallNumber: UILabel!
    
    var cellData: KinderInfo? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    var buttonClicked: (() -> Void)? = nil
    
    // DetailVC로 가는 버튼
    @IBAction func viewMoreBtnClicked(_ sender: UIButton) {
        print(#fileID, #function, #line, "- button clicked")
        buttonClicked?()
        
    }
    
    func updateUI(_ cellData: KinderInfo) {
        guard let kindergartenName = cellData.kindername,
              let kindergartenAddress = cellData.addr,
              let kindergartenCallNumber = cellData.telno
        else {
            print(#fileID, #function, #line, "- 이름, 주소, 전화번호 없음")
            return
        }
        
        self.cellData = cellData
        
        self.kindergartenName.text = kindergartenName
        self.kindergartenAddress.text = kindergartenAddress
        self.kindergartenCallNumber.text = kindergartenCallNumber
        
    }
    
    
}
