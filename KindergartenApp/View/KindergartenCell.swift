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
    
    var viewModel =  ViewModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    var buttonClicked: (() -> Void)? = nil
    var sendToPageVC: (() -> Void)? = nil
    
    // DetailVC로 가는 버튼
    @IBAction func viewMoreBtnClicked(_ sender: UIButton) {
        print(#fileID, #function, #line, "- button clicked")
        buttonClicked?()
        sendToPageVC?()
    }
    
    func updateUI(_ cellData: KinderInfo) {
        guard let kindergartenName = cellData.kindername,
              let kindergartenAddress = cellData.addr,
              let kindergartenCallNumber = cellData.telno
        else {
            print(#fileID, #function, #line, "- 이름, 주소, 전화번호 없음")
            return
        }
        
        self.kindergartenName.text = kindergartenName
        self.kindergartenAddress.text = kindergartenAddress
        self.kindergartenCallNumber.text = kindergartenCallNumber
        
    }
    
    
}
