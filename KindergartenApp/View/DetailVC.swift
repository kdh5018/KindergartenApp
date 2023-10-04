//
//  DetailVC.swift
//  KindergartenApp
//
//  Created by 김도훈 on 2023/09/05.
//

import UIKit

class DetailVC: UIViewController, UIScrollViewDelegate {

    var selectedKindergarten: KinderInfo?
    
    @IBOutlet weak var kindergartenName: UILabel!
    @IBOutlet weak var publicPrivate: UILabel!
    @IBOutlet weak var kindergartenAddress: UILabel!
    @IBOutlet weak var kindergartenCallNumber: UITextView!
    @IBOutlet weak var kindergartenHomepage: UILabel!
    @IBOutlet weak var kindergartenTime: UILabel!
    @IBOutlet weak var kindergartenBossName: UILabel!
    
    @IBOutlet weak var containerView: UIView!

    @IBOutlet weak var pageControl: UIPageControl!
    
    var embededPageVC: PageVC? {
        return children.first(where: { $0 is PageVC}) as? PageVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(openURL))
        kindergartenHomepage.isUserInteractionEnabled = true
        kindergartenHomepage.addGestureRecognizer(tap)

        pageControl.numberOfPages = embededPageVC?.vcArray.count ?? 0
        pageControl.currentPage = 0
        pageControl.isUserInteractionEnabled = false
        
        embededPageVC?.currentPageChanged = { [weak self] currentPage in
            self?.pageControl.currentPage = currentPage
        }
    
        
        if let callNumber = selectedKindergarten?.telno {
            kindergartenCallNumber.text = callNumber
            
            // Tap Gesture Recognizer 생성 및 설정
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(callPhoneNumber(_:)))
            
            kindergartenCallNumber.isUserInteractionEnabled = true
            kindergartenCallNumber.isEditable = false
            kindergartenCallNumber.isSelectable = true
            kindergartenCallNumber.dataDetectorTypes = .phoneNumber
            kindergartenCallNumber.addGestureRecognizer(tapGestureRecognizer)
            
            
        }
        
    }
    @objc func openURL() {
        if let urlText = kindergartenHomepage.text,
           let encodedUrlString = urlText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let url = URL(string: encodedUrlString) {
            UIApplication.shared.open(url)
        }
    }
    
    func setupUI() {
        kindergartenName.text = selectedKindergarten?.kindername
        publicPrivate.text = selectedKindergarten?.establish
        kindergartenAddress.text = selectedKindergarten?.addr
        kindergartenCallNumber.text = selectedKindergarten?.telno
        kindergartenHomepage.text = selectedKindergarten?.hpaddr
        kindergartenTime.text = selectedKindergarten?.opertime
        kindergartenBossName.text = selectedKindergarten?.ldgrname
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
