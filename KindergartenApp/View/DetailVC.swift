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
    @IBOutlet weak var kindergartenHomepage: UITextView!
    @IBOutlet weak var kindergartenTime: UILabel!
    @IBOutlet weak var kindergartenBossName: UILabel!
        
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(#fileID, #function, #line, "- 디테일selectedKindergarten: \(selectedKindergarten)")
        
        setupUI()
        
//        pageControl.addTarget(self, action: #selector(pageChanged), for: .valueChanged)
        
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
            kindergartenCallNumber.isEditable = false
            kindergartenCallNumber.isSelectable = true
            kindergartenCallNumber.dataDetectorTypes = .phoneNumber
            kindergartenCallNumber.addGestureRecognizer(tapGestureRecognizer)
            
            
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
        

//
//        pageControl.currentPageIndicatorTintColor = UIColor.black
//        pageControl.pageIndicatorTintColor = UIColor.lightGray
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//       let pageIndex = Int(scrollView.contentOffset.x / view.frame.width)
//       pageControl.currentPage = pageIndex
//    }

    
    @objc func pageChanged(_ sender: UIPageControl) {
//        let count = pageControl.currentPage
//        switch count {
//        case 0:
//            classLabel.text = "만 3세 학급수: "
//            recruitmentLabel.text = "만 3세 모집정원수: "
//            peopleLabel.text = "만 3세 유아수: "
//            
//            classCount.text = selectedKindergarten?.clcnt3
//            recruitmentCount.text = selectedKindergarten?.ag3fpcnt
//            peopleCount.text = selectedKindergarten?.ppcnt3
//            
//        case 1:
//            classLabel.text = "만 4세 학급수: "
//            recruitmentLabel.text = "만 4세 모집정원수: "
//            peopleLabel.text = "만 4세 유아수: "
//            
//            classCount.text = selectedKindergarten?.clcnt4
//            recruitmentCount.text = selectedKindergarten?.ag4fpcnt
//            peopleCount.text = selectedKindergarten?.ppcnt4
//            
//        case 2:
//            classLabel.text = "만 5세 학급수: "
//            recruitmentLabel.text = "만 5세 모집정원수: "
//            peopleLabel.text = "만 5세 유아수: "
//            
//            classCount.text = selectedKindergarten?.clcnt5
//            recruitmentCount.text = selectedKindergarten?.ag5fpcnt
//            peopleCount.text = selectedKindergarten?.ppcnt5
//            
//        case 3:
//            classLabel.text = "혼합 학급수: "
//            recruitmentLabel.text = "혼합 모집 모집정원수: "
//            peopleLabel.text = "혼합 유아수: "
//            
//            classCount.text = selectedKindergarten?.mixclcnt
//            recruitmentCount.text = selectedKindergarten?.mixfpcnt
//            peopleCount.text = selectedKindergarten?.mixppcnt
//            
//        case 4:
//            classLabel.text = "특수 학급수: "
//            recruitmentLabel.text = "특수 학급 모집정원수: "
//            peopleLabel.text = "특수 유아수: "
//            
//            classCount.text = selectedKindergarten?.shclcnt
//            recruitmentCount.text = selectedKindergarten?.spcnfpcnt
//            peopleCount.text = selectedKindergarten?.shppcnt
//            
//        default:
//            print(#fileID, #function, #line, "- comment")
//        }
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
