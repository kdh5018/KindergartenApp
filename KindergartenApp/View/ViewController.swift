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
    @IBOutlet weak var clearButton: UIButton!
    
    

    
    var viewModel = ViewModel()
    
    var disposeBag = DisposeBag()
    
    var selectedSidoName : String?
    
    var kinderInfo: [KinderInfo] = []
    
    let sidos = ["서울특별시", "부산광역시", "대구광역시", "인천광역시", "광주광역시", "대전광역시", "울산광역시", "세종특별자치시", "경기도", "강원특별자치도", "충청북도", "충청남도", "전라북도", "전라남도", "경상북도", "경상남도", "제주특별자치도"]
    
    let seouls = ["강남구", "강동구", "강북구", "강서구", "관악구", "광진구", "구로구", "금천구", "노원구", "도봉구", "동대문구", "동작구", "마포구", "서대문구", "서초구", "성동구", "성북구", "송파구", "양천구", "영등포구", "용산구", "은평구", "종로구", "중구", "중랑구"]
    
    let busans = ["강서구", "금정구", "기장군", "남구", "동구", "동래구", "부산진구", "북구", "사상구", "사하구", "서구", "수영구", "연제구", "영도구", "중구", "해운대구"]
    
    let daegus = ["군위군", "남구", "달서구", "달성군", "동구", "북구", "서구", "수성구", "중구"]
    
    let incheons = ["계양구", "남동구", "동구", "미추홀구", "부평구", "서구", "연수구", "옹진군", "중구"]
    
    let gwangjus = ["광산구", "남구", "동구", "북구", "서구"]
    
    let daejeons = ["대덕구", "동구", "서구", "유성구", "중구"]
    
    let ulsans = ["남구", "동구", "북구", "울주군", "중구"]
    
    let sejongs = ["세종특별자치시"]
    
    let gyeonggis = ["가평군", "고양시 덕양구", "고양시 일산동구", "고양시 일산서구", "과천시", "광명시", "광주시", "구리시", "군포시", "남양주시", "동두천시", "부천시", "성남시 분당구", "성남시 수정구", "성남시 중원구", "수원시 권선구", "수원시 영통구", "수원시 장안구", "수원시 팔달구", "시흥시", "안산시 단원구", "안산시 상록구", "안성시", "안양시 동안구", "안양시 만안구", "양주시", "양평군", "여주시", "연천군", "오산시", "용인시 기흥구", "용인시 수지구", "용인시 처인구", "의왕시", "의정부시", "이천시", "파주시", "평택시", "포천시", "하남시", "화성시"]
    
    let gangwons = ["강릉시", "고성군", "동해시", "삼척시", "속초시", "양구군", "양양군", "영월군", "원주시", "인제군", "정선군", "철원군", "춘천시", "태백시", "평창군", "홍천군", "화천군", "횡성군"]
    
    let chungbuks = ["괴산군", "단양군", "보은군", "영동군", "옥천군", "음성군", "제천시", "증평군", "진천군", "청주시 상당구", "청주시 서원구", "청주시 청원구", "청주시 흥덕구", "충주시"]
    
    let chungnams = ["계룡시", "공주시", "금산군", "논산시", "당진시", "보령시", "부여군", "서산시", "서천군", "아산시", "예산군", "천안시 동남구", "천안시 서북구", "청양군", "태안군", "홍성군"]
    
    let jeonbuks = ["고창군", "군산시", "김제시", "남원시", "무주군", "부안군", "순창군", "완주군", "익산시", "임실군", "장수군", "전주시 덕진구", "전주시 완산구", "정읍시", "진안군"]
    
    let jeonnams = ["강진군", "고흥군", "곡성군", "광양시", "구례군", "나주시", "담양군", "목포시", "무안군", "보성군", "순천시", "신안군", "여수시", "영광군", "영암군", "완도군", "장성군", "장흥군", "진도군", "함평군", "해남군", "화순군"]
    
    let gyeongbuks = ["경산시", "경주시", "고령군", "구미시", "김천시", "문경시", "봉화군", "상주시", "성주군", "안동시", "영덕군", "영양군", "영주시", "영천시", "예천군", "울릉군", "울진군", "의성군", "청도군", "청송군", "칠곡군", "포항시 남구", "포항시 북구",]
    
    let gyeongnams = ["거제시", "거창군", "고성군", "김해시", "남해군", "밀양시", "사천시", "산청군", "양산시", "의령군", "진주시", "창녕군", "창원시 마산합포구", "창원시 마산회원구", "창원시 성산구", "창원시 의창구", "창원시 진해구", "통영시", "하동군", "함안군", "함양군"]
    
    let jejus = ["서귀포시", "제주시"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 시/도 팝업버튼
        sidoPopupButton()

        myTableView.register(KindergartenCell.uinib, forCellReuseIdentifier: KindergartenCell.reuseIdentifier)
        
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.rowHeight = UITableView.automaticDimension
        
        // 뷰모델 이벤트 받기 - 뷰 - 뷰모델 바인딩 - 묶기
        self.rxBindViewModel(viewModel: self.viewModel)
    }
    
    // 시/도 버튼으로 시도를 골라야지만 시/군/구 버튼을 누를 수 있게
    @IBAction func sidoBtnClicked(_ sender: UIButton) {
        sidoPopupButton()
    }
    

    func sidoPopupButton() {
        #warning("초기 버튼 화면은 시/도 로 되어야 함")
//        sidoButton.setTitle("시/도", for: .normal)
        
        let optionClosure = {(action: UIAction) in
            self.selectedSidoName = action.title
            self.sigunguPopupButton(selectedSidoName: self.selectedSidoName ?? "nil")
        }

        let actions = sidos.map { sido in
            UIAction(title: sido, handler: optionClosure)
        }
        
        sidoButton.menu = UIMenu(children: actions)
        
        sidoButton.showsMenuAsPrimaryAction = true
        sidoButton.changesSelectionAsPrimaryAction = true
        
        
    }
    
    func sigunguPopupButton(selectedSidoName: String) {
        
        let optionClosure = {(action: UIAction) in
            print(action.title)
        }
        
        var actions: [UIAction] = []
        
        switch selectedSidoName {
        case "서울특별시":
            actions = seouls.map { seoul in
                UIAction(title: seoul, handler: optionClosure)
            }

        case "부산광역시":
            actions = busans.map { busan in
                UIAction(title: busan, handler: optionClosure)
            }

        case "대구광역시":
            actions = daegus.map { daegu in
                UIAction(title: daegu, handler: optionClosure)
            }
        case "인천광역시":
            actions = incheons.map { incheon in
                UIAction(title: incheon, handler: optionClosure)
            }
        case "광주광역시":
            actions = gwangjus.map { gwangju in
                UIAction(title: gwangju, handler: optionClosure)
            }
        case "대전광역시":
            actions = daejeons.map { daejeon in
                UIAction(title: daejeon, handler: optionClosure)
            }
        case "울산광역시":
            actions = ulsans.map { ulsan in
                UIAction(title: ulsan, handler: optionClosure)
            }
        case "세종특별자치시":
            actions = sejongs.map { sejong in
                UIAction(title: sejong, handler: optionClosure)
            }
        case "경기도":
            actions = gyeonggis.map { gyeonggi in
                UIAction(title: gyeonggi, handler: optionClosure)
            }
        case "강원특별자치도":
            actions = gangwons.map { gangwon in
                UIAction(title: gangwon, handler: optionClosure)
            }
        case "충청북도":
            actions = chungbuks.map { chungbuk in
                UIAction(title: chungbuk, handler: optionClosure)
            }
        case "충청남도":
            actions = chungnams.map { chungnam in
                UIAction(title: chungnam, handler: optionClosure)
            }
        case "전라북도":
            actions = jeonbuks.map { jeonbuk in
                UIAction(title: jeonbuk, handler: optionClosure)
            }
        case "전라남도":
            actions = jeonnams.map { jeonnam in
                UIAction(title: jeonnam, handler: optionClosure)
            }
        case "경상북도":
            actions = gyeongbuks.map { gyeongbuk in
                UIAction(title: gyeongbuk, handler: optionClosure)
            }
        case "경상남도":
            actions = gyeongnams.map { gyeongnam in
                UIAction(title: gyeongnam, handler: optionClosure)
            }
        case "제주특별자치도":
            actions = jejus.map { jeju in
                UIAction(title: jeju, handler: optionClosure)
            }


        default:
            print("선택된 도시 없음")
        }
        
        sigunguButton.menu = UIMenu(children: actions)
        
        sigunguButton.showsMenuAsPrimaryAction = true
        sigunguButton.changesSelectionAsPrimaryAction = true
        
    }
    
    @IBAction func findKindergartenBtnClicked(_ sender: UIButton) {
        viewModel.fetchKindergarten(27, 27140)
    }
    
    @IBAction func clearBtnClicked(_ sender: UIButton) {
        
    }
    
    
}

extension ViewController {
    //MARK: - 뷰모델 바인딩 관련 VM -> View (Rx)
    private func rxBindViewModel(viewModel: ViewModel) {
        self.viewModel
            .kinderInfo
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { vm, fetchedKindergarten in
                vm.kinderInfo = fetchedKindergarten
                vm.myTableView.reloadData()
            })
            .disposed(by: disposeBag)
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
            let storyboard = UIStoryboard(name: "DetailVC", bundle: nil)
            let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
            
            self?.navigationController?.pushViewController(detailVC, animated: true)
        }
        
        
        let cellData: KinderInfo = self.kinderInfo[indexPath.row]
        
        cell.updateUI(cellData)
        
        return cell
    }
    
    
}

extension ViewController: UITableViewDelegate {
    
}

