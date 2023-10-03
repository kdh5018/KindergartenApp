//
//  OnboardingPageController.swift
//  KindergartenApp
//
//  Created by 김도훈 on 2023/10/03.
//

import Foundation
import UIKit

class OnboardingPageController: UIPageViewController {
    
    var selectedKindergarten: KinderInfo?
    
    var numbers: [Int] = [0, 1, 2, 3, 4]
    
    var pageVCList: [PagingVC] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#fileID, #function, #line, "- ")
        
        pageVCList = numbers.map{ PagingVC.getInstance(index: $0) }
        
        setViewControllers([pageVCList[0]], direction: .forward, animated: true, completion: { value in
            print(#fileID, #function, #line, "- value: \(value)")
        })
    }
    
}
