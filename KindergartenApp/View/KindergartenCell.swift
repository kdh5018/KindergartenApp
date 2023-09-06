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

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    var buttonClicked: (() -> Void)?
    
    @IBAction func viewMoreBtnClicked(_ sender: UIButton) {
        print(#fileID, #function, #line, "- button clicked")
        buttonClicked?()

    }
    
    
}
