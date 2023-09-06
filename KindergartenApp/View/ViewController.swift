//
//  ViewController.swift
//  KindergartenApp
//
//  Created by 김도훈 on 2023/09/05.
//

import UIKit
import RxSwift
import RxRelay
import RxCocoa

class ViewController: UIViewController {
    
    
    @IBOutlet weak var myTableView: UITableView!
    
    
    var viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        myTableView.register(KindergartenCell.uinib, forCellReuseIdentifier: KindergartenCell.reuseIdentifier)
        
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.rowHeight = UITableView.automaticDimension
    }


}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: KindergartenCell.reuseIdentifier, for: indexPath) as? KindergartenCell else {
            return UITableViewCell()
        }
        
        cell.buttonClicked = { [weak self] in
            print(#fileID, #function, #line, "- 뷰컨 버튼 할당")
            let storyboard = UIStoryboard(name: "DetailVC", bundle: nil)
            let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
            
            self?.navigationController?.pushViewController(detailVC, animated: true)
//            self?.navigationItem.backBarButtonItem?.title = "뒤로 가기"
        }
        
        
        return cell
    }
    
    
}

extension ViewController: UITableViewDelegate {
    
}
