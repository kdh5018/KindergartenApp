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
    
    @IBOutlet weak var sidoButton: UIButton!
    @IBOutlet weak var sigunguButton: UIButton!
    @IBOutlet weak var findKindergartenButton: UIButton!
    
    @IBOutlet weak var guideLabel: UILabel!
    
    var viewModel = ViewModel()
    
    var disposeBag = DisposeBag()
    
    var selectedSidoName: String?
    
    var selectedSidogunName: String?
    
    var kinderInfo: [KinderInfo] = []
    
    var kindergartenTableViewCell = KindergartenCell()
    
    // 초기 화면 뷰(지역 선택 유도)
    lazy var induceView: UIView = {
        
        let view: UIView = UIView(frame: CGRect(x: 0, y: 0, width: myTableView.bounds.width, height: 300))
        
        let label: UILabel = UILabel()
        label.text = "원하는 지역을 선택해주세요👶🏻 \n시/도 → 시/군/구 순서로 선택해주세요🐥"
        label.numberOfLines = 2
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        return view
    }()
    
    // 선택 후 로딩
    lazy var indicator: UIActivityIndicatorView = {
        let indicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
        indicator.color = UIColor.systemGray
        indicator.startAnimating()
        indicator.frame = CGRect(x: 0, y: 0, width: myTableView.bounds.width, height: 100)
        return indicator
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 시/도 팝업버튼
        sidoListArranged()
        
        sidoButton.setTitle("시/도", for: .normal)
        sigunguButton.setTitle("시/군/구", for: .normal)
        
        configureTableView()
        
        sigunguButton.isUserInteractionEnabled = false
        
        self.guideLabel.text = "해당 정보는 교육부 - 유치원알리미에서 제공하는 정보입니다. \n보다 자세한 정보는 희망하시는 유치원에 문의하시기 바랍니다."
        self.guideLabel.numberOfLines = 2
        
        // 뷰모델 이벤트 받기 - 뷰 - 뷰모델 바인딩 - 묶기
        self.rxBindViewModel(viewModel: self.viewModel)
    }
    
    fileprivate func configureTableView() {
        self.myTableView.register(KindergartenCell.uinib, forCellReuseIdentifier: KindergartenCell.reuseIdentifier)
        self.myTableView.dataSource = self
        self.myTableView.delegate = self
        self.myTableView.rowHeight = UITableView.automaticDimension
        
        self.myTableView.tableFooterView = indicator
    }
    
    
    // 시/도 버튼으로 시도를 골라야지만 시/군/구 버튼을 누를 수 있게
    @IBAction func sidoBtnClicked(_ sender: UIButton) {
        sidoListArranged()
    }
    

    func sidoListArranged() {
        
        let optionClosure = {(action: UIAction) in
            self.selectedSidoName = action.title
            self.sigunguPopupButtonTapped(selectedSidoName: self.selectedSidoName ?? "nil")
        }
        
        

        let actions = Sido.allCases.map { sido in
            UIAction(title: sido.rawValue, handler: optionClosure)
        }
        
        sidoButton.menu = UIMenu(children: actions)
        
        
        sidoButton.showsMenuAsPrimaryAction = true
        sidoButton.changesSelectionAsPrimaryAction = true
        
    }
    
    // don't repeat
    
    // !! edit function name
    func sigunguPopupButtonTapped(selectedSidoName: String) {
        
        if selectedSidoName != nil {
            sigunguButton.isUserInteractionEnabled = true
        }
        
        let action = { (action: UIAction) in
            print(action.title)
            self.selectedSidogunName = action.title
            
        }

        let actions = makeLocationSelectAction(selectedSidoName, optionClosure: action)
        
        
        sigunguButton.menu = UIMenu(children: actions)
        
        
        sigunguButton.showsMenuAsPrimaryAction = true
        sigunguButton.changesSelectionAsPrimaryAction = true
        
    }
    
    fileprivate func makeLocationSelectAction(_ selectedSidoName: String,
                                              optionClosure: @escaping (UIAction) -> Void) -> [UIAction] {
        var actions: [UIAction] = []
                
                switch selectedSidoName {
                case "시/도":
                    actions = None.allCases.map{ no in
                        UIAction(title: no.rawValue, handler: optionClosure)
                    }

                case "서울특별시":
                    actions = Seoul.allCases.map { seoul in
                        UIAction(title: seoul.rawValue, handler: optionClosure)
                    }

                case "부산광역시":
                    actions = Busan.allCases.map { busan in
                        UIAction(title: busan.rawValue, handler: optionClosure)
                    }

                case "대구광역시":
                    actions = Daegu.allCases.map { daegu in
                        UIAction(title: daegu.rawValue, handler: optionClosure)
                    }
                case "인천광역시":
                    actions = Incheon.allCases.map { incheon in
                        UIAction(title: incheon.rawValue, handler: optionClosure)
                    }
                case "광주광역시":
                    actions = Gwangju.allCases.map { gwangju in
                        UIAction(title: gwangju.rawValue, handler: optionClosure)
                    }
                case "대전광역시":
                    actions = Daejeon.allCases.map { daejeon in
                        UIAction(title: daejeon.rawValue, handler: optionClosure)
                    }
                case "울산광역시":
                    actions = Ulsan.allCases.map { ulsan in
                        UIAction(title: ulsan.rawValue, handler: optionClosure)
                    }
                case "세종특별자치시":
                    actions = Sejong.allCases.map { sejong in
                        UIAction(title: sejong.rawValue, handler: optionClosure)
                    }
                case "경기도":
                    actions = Gyeonggi.allCases.map { gyeonggi in
                        UIAction(title: gyeonggi.rawValue, handler: optionClosure)
                    }
                case "강원특별자치도":
                    actions = Gangwon.allCases.map { gangwon in
                        UIAction(title: gangwon.rawValue, handler: optionClosure)
                    }
                case "충청북도":
                    actions = Chungbuk.allCases.map { chungbuk in
                        UIAction(title: chungbuk.rawValue, handler: optionClosure)
                    }
                case "충청남도":
                    actions = Chungnam.allCases.map { chungnam in
                        UIAction(title: chungnam.rawValue, handler: optionClosure)
                    }
                case "전라북도":
                    actions = Jeonbuk.allCases.map { jeonbuk in
                        UIAction(title: jeonbuk.rawValue, handler: optionClosure)
                    }
                case "전라남도":
                    actions = Jeonnam.allCases.map { jeonnam in
                        UIAction(title: jeonnam.rawValue, handler: optionClosure)
                    }
                case "경상북도":
                    actions = Gyeongbuk.allCases.map { gyeongbuk in
                        UIAction(title: gyeongbuk.rawValue, handler: optionClosure)
                    }
                case "경상남도":
                    actions = Gyeongnam.allCases.map { gyeongnam in
                        UIAction(title: gyeongnam.rawValue, handler: optionClosure)
                    }
                case "제주특별자치도":
                    actions = Jeju.allCases.map { jeju in
                        UIAction(title: jeju.rawValue, handler: optionClosure)
                    }


                default:
                    print("선택된 도시 없음")
                }
        return actions
    }
    
    // 내가 지정한 지역코드가 들어간 유치원 찾기 버튼
    @IBAction func findKindergartenBtnClicked(_ sender: UIButton) {

        viewModel.sigunguSelected(selectedSidoName ?? "",selectedSidogunName ?? "")
        
      }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "DetailVC",
           let destinationVC = segue.destination as? DetailVC,
           let selectedKindergarten = sender as? KinderInfo {
            
            destinationVC.selectedKindergarten = selectedKindergarten
            
        }
    }
    
}

extension ViewController {
    //MARK: - 뷰모델 바인딩 관련 VM -> View (Rx)
    private func rxBindViewModel(viewModel: ViewModel) {
        
        // 테이블뷰셀에 지정된 유치원 정보 보여줌
        self.viewModel
            .kinderInfo
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { mainVC, fetchedKindergarten in
                mainVC.kinderInfo = fetchedKindergarten
                mainVC.myTableView.reloadData()
            })
            .disposed(by: disposeBag)
        
        // 초기화면 지역 선택 전 유도하는 뷰
        self.viewModel
            .induceKindergarten
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { mainVC, induce in
                self.myTableView.backgroundView = induce ? self.induceView : nil
            })
            .disposed(by: disposeBag)
        
        // 재검색하면 테이블뷰 맨 위로 올리기
        self.viewModel
            .scrollToTop
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { mainVC, _ in
                self.myTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
                self.myTableView.reloadData()
            }).disposed(by: disposeBag)
        
        // 지역 선택 후 보여주기 전까지 로딩 UI 보여주기
        self.viewModel
            .isLoading
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { mainVC, isLoading in
                
                self.myTableView.tableFooterView = isLoading ? self.indicator : nil
            })
        
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kinderInfo.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: KindergartenCell.reuseIdentifier, for: indexPath) as? KindergartenCell else {
            return UITableViewCell()
        }
        
        cell.buttonClicked = { [weak self] in
            print(#fileID, #function, #line, "- 뷰컨 버튼 할당")
            
            guard let self = self else { return }
            
            let storyboard = UIStoryboard(name: "DetailVC", bundle: nil)
            let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
            
            detailVC.selectedKindergarten = self.kinderInfo[indexPath.row]
            
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
        
        cell.sendToPageVC = { [weak self] in
            guard let self = self else { return }
            
            DataController.shared.selectedKindergarten = self.kinderInfo[indexPath.row]
        }
        
        
        let cellData = self.kinderInfo[indexPath.row]
        
        // 뷰컨트롤러 테이블뷰셀
        cell.updateUI(cellData)
        
        return cell
    }
    
    
}

extension ViewController: UITableViewDelegate {
    
}

