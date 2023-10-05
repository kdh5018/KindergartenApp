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
    
    @IBOutlet weak var containerView: UIView!

    @IBOutlet weak var pageControl: UIPageControl!
    
    var embededPageVC: PageVC? {
        return children.first(where: { $0 is PageVC}) as? PageVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        let urlTap = UITapGestureRecognizer(target: self, action: #selector(openURL))
        kindergartenHomepage.isUserInteractionEnabled = true
        kindergartenHomepage.addGestureRecognizer(urlTap)
        
        let callNumberTap = UITapGestureRecognizer(target: self, action: #selector(makePhoneCall))
        kindergartenCallNumber.isUserInteractionEnabled = true
        kindergartenCallNumber.addGestureRecognizer(callNumberTap)
        

        pageControl.numberOfPages = embededPageVC?.vcArray.count ?? 0
        pageControl.currentPage = 0
        pageControl.isUserInteractionEnabled = false
        
        embededPageVC?.currentPageChanged = { [weak self] currentPage in
            self?.pageControl.currentPage = currentPage
        }
        
    }
    
    // url 연결 셀렉터
    @objc func openURL() {
        if let urlText = kindergartenHomepage.text,
           let encodedUrlString = urlText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let url = URL(string: encodedUrlString) {
            UIApplication.shared.open(url)
        }
    }
    
    // 전화연결 셀렉터
    @objc func makePhoneCall() {
        if let phoneNumber = extractPhoneNumber(from: kindergartenCallNumber.text) {
            if let phoneURL = URL(string: "tel://\(phoneNumber)") {
                UIApplication.shared.open(phoneURL)
            }
        }
    }
    
    func extractPhoneNumber(from text: String?) -> String? {
        guard let text = text else { return nil }
        
        // 텍스트에서 숫자가 아닌 문자를 제거
        let digitsOnlyText = text.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        
        // 결과 문자열이 유효한 전화번호인지 확인
        if digitsOnlyText.count >= 9 && digitsOnlyText.count <= 15 {
            return digitsOnlyText
        } else {
            return nil
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


}
