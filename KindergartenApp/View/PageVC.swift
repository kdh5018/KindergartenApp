//
//  PageVC.swift
//  KindergartenApp
//
//  Created by 김도훈 on 2023/10/03.
//

import UIKit

class PageVC: UIPageViewController {
    
    lazy var vcArray: [UIViewController] = {
        return [self.vcInstance(name: "Old3VC"),
                self.vcInstance(name: "Old4VC"),
                self.vcInstance(name: "Old5VC"),
                self.vcInstance(name: "OldMixVC"),
                self.vcInstance(name: "OldSpecialVC")]
    }()
    
    private func vcInstance(name: String) -> UIViewController {
        return UIStoryboard(name: "DetailVC", bundle: nil).instantiateViewController(withIdentifier: name)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self
        self.delegate = self
        
        if let firstVC = vcArray.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        
    }
    

}

extension PageVC: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        // 배열에서 현재 페이지의 컨트롤러를 찾아서 해당 인덱스를 현재 인덱스로 기록
        guard let vcIndex = vcArray.firstIndex(of: viewController) else { return nil }
        
        // 이전 페이지 인덱스
        let prevIndex = vcIndex - 1
        
        // 인덱스가 0 이상이라면 그냥 놔둠
        guard prevIndex >= 0 else {
            return nil
            
            // 무한반복 시 - 1페이지에서 마지막 페이지로 가야함
            // return vcArray.last
        }
        
        // 인덱스는 vcArray.count 이상이 될 수 없음
        guard vcArray.count > prevIndex else { return nil }
        
        return vcArray[prevIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = vcArray.firstIndex(of: viewController) else { return nil }
        
        // 다음 페이지 인덱스
        let nextIndex = vcIndex + 1
        
        guard nextIndex < vcArray.count else {
            return nil
            
            // 무한반복 시 - 마지막 페이지에서 1 페이지로 가야함
            // return vcArray.first
        }
        
        guard vcArray.count > nextIndex else { return nil }
        
        return vcArray[nextIndex]
    }
    
    
}
