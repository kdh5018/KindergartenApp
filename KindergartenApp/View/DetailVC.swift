//
//  DetailVC.swift
//  KindergartenApp
//
//  Created by 김도훈 on 2023/09/05.
//

import UIKit

class DetailVC: UIViewController {

    var selectedKindergarten: KinderInfo?
    
    @IBOutlet weak var kindergartenName: UILabel!
    @IBOutlet weak var publicPrivate: UILabel!
    @IBOutlet weak var kindergartenAddress: UILabel!
    @IBOutlet weak var kindergartenCallNumber: UILabel!
    @IBOutlet weak var kindergartenHomepage: UITextView!
    @IBOutlet weak var kindergartenTime: UILabel!
    @IBOutlet weak var kindergartenBossName: UILabel!
    
    @IBOutlet weak var class3: UILabel!
    @IBOutlet weak var recruitmentClass3: UILabel!
    @IBOutlet weak var peopleCount3: UILabel!
    
    @IBOutlet weak var class4: UILabel!
    @IBOutlet weak var recruitmentClass4: UILabel!
    @IBOutlet weak var peopleCount4: UILabel!
    
    @IBOutlet weak var class5: UILabel!
    @IBOutlet weak var recruitmentClass5: UILabel!
    @IBOutlet weak var peopleCount5: UILabel!
    
    @IBOutlet weak var classMix: UILabel!
    @IBOutlet weak var recruitmentClassMix: UILabel!
    @IBOutlet weak var peopleCountMix: UILabel!
    
    @IBOutlet weak var classSpecial: UILabel!
    @IBOutlet weak var recruitmentClassSpecial: UILabel!
    @IBOutlet weak var peopleCountSpecial: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        kindergartenName.text = selectedKindergarten?.kindername
        publicPrivate.text = selectedKindergarten?.establish
        kindergartenAddress.text = selectedKindergarten?.addr
        kindergartenCallNumber.text = selectedKindergarten?.telno
        kindergartenHomepage.text = selectedKindergarten?.hpaddr
        kindergartenTime.text = selectedKindergarten?.opertime
        kindergartenBossName.text = selectedKindergarten?.ldgrname
        
        class3.text = selectedKindergarten?.clcnt3
        recruitmentClass3.text = selectedKindergarten?.ag3fpcnt
        peopleCount3.text = selectedKindergarten?.ppcnt3
        
        class4.text = selectedKindergarten?.clcnt4
        recruitmentClass4.text = selectedKindergarten?.ag4fpcnt
        peopleCount4.text = selectedKindergarten?.ppcnt4
        
        class5.text = selectedKindergarten?.clcnt5
        recruitmentClass5.text = selectedKindergarten?.ag4fpcnt
        peopleCount5.text = selectedKindergarten?.ppcnt5
        
        classMix.text = selectedKindergarten?.mixclcnt
        recruitmentClassMix.text = selectedKindergarten?.mixfpcnt
        peopleCountMix.text = selectedKindergarten?.mixppcnt
        
        classSpecial.text = selectedKindergarten?.shclcnt
        recruitmentClassSpecial.text = selectedKindergarten?.spcnfpcnt
        peopleCountSpecial.text = selectedKindergarten?.shppcnt
        
        // 링크 누르면 해당 링크로 이동
        if let homepageURL = selectedKindergarten?.hpaddr {
            // URL 문자열 생성 및 링크 속성 설정
            let attributedString = NSMutableAttributedString(string: homepageURL)
            attributedString.addAttribute(.link, value: homepageURL, range: NSRange(location: 0, length: homepageURL.count))
            
            // TextView 설정
            kindergartenHomepage.attributedText = attributedString
            kindergartenHomepage.isUserInteractionEnabled = true // 사용자와의 상호작용 활성화
        }
        
        if let callNumber = selectedKindergarten?.telno {
            kindergartenCallNumber.text = callNumber
            
            // Tap Gesture Recognizer 생성 및 설정
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(callPhoneNumber(_:)))
            
            kindergartenCallNumber.isUserInteractionEnabled = true
            kindergartenCallNumber.addGestureRecognizer(tapGestureRecognizer)
        }
        
    }
    
    @objc func callPhoneNumber(_ sender: UITapGestureRecognizer) {
        if let phoneNumberLabel = sender.view as? UILabel,
           let phoneNumber = phoneNumberLabel.text,
           let url = URL(string: "tel://\(phoneNumber)"),
           UIApplication.shared.canOpenURL(url) {
                   switch sender.state {
                   case .began:
                       phoneNumberLabel.isHighlighted = true // 버튼이 눌린 것처럼 보임
                   case .ended:
                       UIApplication.shared.open(url, options: [:], completionHandler: nil)
                       fallthrough // ended 상태에서는 항상 highlighted 상태를 해제해야 함
                   default:
                       phoneNumberLabel.isHighlighted = false // 버튼이 안눌린 것처럼 보임
                   }
               }
    }


}
