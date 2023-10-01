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
    
    let sidos = ["시/도", "서울특별시", "부산광역시", "대구광역시", "인천광역시", "광주광역시", "대전광역시", "울산광역시", "세종특별자치시", "경기도", "강원특별자치도", "충청북도", "충청남도", "전라북도", "전라남도", "경상북도", "경상남도", "제주특별자치도"]
    
    let seouls = ["시/군/구", "강남구", "강동구", "강북구", "강서구", "관악구", "광진구", "구로구", "금천구", "노원구", "도봉구", "동대문구", "동작구", "마포구", "서대문구", "서초구", "성동구", "성북구", "송파구", "양천구", "영등포구", "용산구", "은평구", "종로구", "중구", "중랑구"]
    
    let busans = ["시/군/구","강서구", "금정구", "기장군", "남구", "동구", "동래구", "부산진구", "북구", "사상구", "사하구", "서구", "수영구", "연제구", "영도구", "중구", "해운대구"]
    
    let daegus = ["시/군/구","군위군", "남구", "달서구", "달성군", "동구", "북구", "서구", "수성구", "중구"]
    
    let incheons = ["시/군/구","계양구", "남동구", "동구", "미추홀구", "부평구", "서구", "연수구", "옹진군", "중구"]
    
    let gwangjus = ["시/군/구","광산구", "남구", "동구", "북구", "서구"]
    
    let daejeons = ["시/군/구","대덕구", "동구", "서구", "유성구", "중구"]
    
    let ulsans = ["시/군/구","남구", "동구", "북구", "울주군", "중구"]
    
    let sejongs = ["시/군/구","세종특별자치시"]
    
    let gyeonggis = ["시/군/구","가평군", "고양시 덕양구", "고양시 일산동구", "고양시 일산서구", "과천시", "광명시", "광주시", "구리시", "군포시", "남양주시", "동두천시", "부천시", "성남시 분당구", "성남시 수정구", "성남시 중원구", "수원시 권선구", "수원시 영통구", "수원시 장안구", "수원시 팔달구", "시흥시", "안산시 단원구", "안산시 상록구", "안성시", "안양시 동안구", "안양시 만안구", "양주시", "양평군", "여주시", "연천군", "오산시", "용인시 기흥구", "용인시 수지구", "용인시 처인구", "의왕시", "의정부시", "이천시", "파주시", "평택시", "포천시", "하남시", "화성시"]
    
    let gangwons = ["시/군/구","강릉시", "고성군", "동해시", "삼척시", "속초시", "양구군", "양양군", "영월군", "원주시", "인제군", "정선군", "철원군", "춘천시", "태백시", "평창군", "홍천군", "화천군", "횡성군"]
    
    let chungbuks = ["시/군/구","괴산군", "단양군", "보은군", "영동군", "옥천군", "음성군", "제천시", "증평군", "진천군", "청주시 상당구", "청주시 서원구", "청주시 청원구", "청주시 흥덕구", "충주시"]
    
    let chungnams = ["시/군/구","계룡시", "공주시", "금산군", "논산시", "당진시", "보령시", "부여군", "서산시", "서천군", "아산시", "예산군", "천안시 동남구", "천안시 서북구", "청양군", "태안군", "홍성군"]
    
    let jeonbuks = ["시/군/구","고창군", "군산시", "김제시", "남원시", "무주군", "부안군", "순창군", "완주군", "익산시", "임실군", "장수군", "전주시 덕진구", "전주시 완산구", "정읍시", "진안군"]
    
    let jeonnams = ["시/군/구","강진군", "고흥군", "곡성군", "광양시", "구례군", "나주시", "담양군", "목포시", "무안군", "보성군", "순천시", "신안군", "여수시", "영광군", "영암군", "완도군", "장성군", "장흥군", "진도군", "함평군", "해남군", "화순군"]
    
    let gyeongbuks = ["시/군/구","경산시", "경주시", "고령군", "구미시", "김천시", "문경시", "봉화군", "상주시", "성주군", "안동시", "영덕군", "영양군", "영주시", "영천시", "예천군", "울릉군", "울진군", "의성군", "청도군", "청송군", "칠곡군", "포항시 남구", "포항시 북구"]
    
    let gyeongnams = ["시/군/구","거제시", "거창군", "고성군", "김해시", "남해군", "밀양시", "사천시", "산청군", "양산시", "의령군", "진주시", "창녕군", "창원시 마산합포구", "창원시 마산회원구", "창원시 성산구", "창원시 의창구", "창원시 진해구", "통영시", "하동군", "함안군", "함양군", "합천군"]
    
    let jejus = ["시/군/구","서귀포시", "제주시"]
    
    // 초기 화면 뷰(지역 선택 유도)
    lazy var induceView: UIView = {
        
        let view: UIView = UIView(frame: CGRect(x: 0, y: 0, width: myTableView.bounds.width, height: 300))
        
        let label: UILabel = UILabel()
        label.text = "원하는 지역을 선택해주세요👶🏻"
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
        sidoPopupButton()

        self.myTableView.register(KindergartenCell.uinib, forCellReuseIdentifier: KindergartenCell.reuseIdentifier)
        
//        sigunguButton.isEnabled = false
        
        sidoButton.setTitle("시/도", for: .normal)
        sigunguButton.setTitle("시/군/구", for: .normal)
        
        self.myTableView.dataSource = self
        self.myTableView.delegate = self
        self.myTableView.rowHeight = UITableView.automaticDimension
        
        self.myTableView.tableFooterView = indicator
        
        self.guideLabel.text = "해당 정보는 교육부 - 유치원알리미에서 제공하는 정보입니다. \n보다 자세한 정보는 희망하는 유치원에 문의하시기 바랍니다."
        self.guideLabel.numberOfLines = 2
        
        print(#fileID, #function, #line, "- selectedSidoName: \(selectedSidoName)")
        
        // 뷰모델 이벤트 받기 - 뷰 - 뷰모델 바인딩 - 묶기
        self.rxBindViewModel(viewModel: self.viewModel)
    }
    
    // 시/도 버튼으로 시도를 골라야지만 시/군/구 버튼을 누를 수 있게
    @IBAction func sidoBtnClicked(_ sender: UIButton) {
        sidoPopupButton()
    }
    

    func sidoPopupButton() {
        
        let optionClosure = {(action: UIAction) in
            self.selectedSidoName = action.title
            self.sigunguPopupButton(selectedSidoName: self.selectedSidoName ?? "nil")
        }

        let actions = sidos.map { sido in
            UIAction(title: sido, handler: optionClosure)
        }
        
        print(#fileID, #function, #line, "- 초기 시도: \(selectedSidoName)")
        
        sidoButton.menu = UIMenu(children: actions)
        
        sidoButton.showsMenuAsPrimaryAction = true
        sidoButton.changesSelectionAsPrimaryAction = true
        
    }
    
    
    func sigunguPopupButton(selectedSidoName: String) {
        
        print(#fileID, #function, #line, "- 설정된 시도: \(selectedSidoName)")
        
        let optionClosure = { (action: UIAction) in
            print(action.title)
            self.selectedSidogunName = action.title
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
    
    // 내가 지정한 지역코드가 들어간 유치원 찾기 버튼
    @IBAction func findKindergartenBtnClicked(_ sender: UIButton) {
        
//        viewModel.isLoading.accept(true)
        
        if selectedSidoName != nil {
            sigunguButton.isEnabled = true
        }

        switch selectedSidoName {
        case "서울특별시":
            switch selectedSidogunName {
                // 서울
            case "강남구":
                viewModel.fetchKindergarten(11, 11680)
            case "강동구":
                viewModel.fetchKindergarten(11, 11740)
            case "강북구":
                viewModel.fetchKindergarten(11, 11305)
            case "강서구":
                viewModel.fetchKindergarten(11, 11500)
            case "관악구":
                viewModel.fetchKindergarten(11, 11620)
            case "광진구":
                viewModel.fetchKindergarten(11, 11215)
            case "구로구":
                viewModel.fetchKindergarten(11, 11530)
            case "금천구":
                viewModel.fetchKindergarten(11, 11545)
            case "노원구":
                viewModel.fetchKindergarten(11, 11350)
            case "도봉구":
                viewModel.fetchKindergarten(11, 11320)
            case "동대문구":
                viewModel.fetchKindergarten(11, 11230)
            case "동작구":
                viewModel.fetchKindergarten(11, 11590)
            case "마포구":
                viewModel.fetchKindergarten(11, 11440)
            case "서대문구":
                viewModel.fetchKindergarten(11, 11410)
            case "서초구":
                viewModel.fetchKindergarten(11, 11650)
            case "성동구":
                viewModel.fetchKindergarten(11, 11200)
            case "성북구":
                viewModel.fetchKindergarten(11, 11290)
            case "송파구":
                viewModel.fetchKindergarten(11, 11710)
            case "양천구":
                viewModel.fetchKindergarten(11, 11470)
            case "영등포구":
                viewModel.fetchKindergarten(11, 11560)
            case "용산구":
                viewModel.fetchKindergarten(11, 11170)
            case "은평구":
                viewModel.fetchKindergarten(11, 11380)
            case "종로구":
                viewModel.fetchKindergarten(11, 11110)
            case "중구":
                viewModel.fetchKindergarten(11, 11140)
            case "중랑구":
                viewModel.fetchKindergarten(11, 11260)
            default:
                print("서울 선택 잘못됨")
            }
            
        case "부산광역시":
            switch selectedSidogunName {
                // 부산
            case "강서구":
                viewModel.fetchKindergarten(26, 26440)
            case "금정구":
                viewModel.fetchKindergarten(26, 26410)
            case "기장군":
                viewModel.fetchKindergarten(26, 26710)
            case "남구":
                viewModel.fetchKindergarten(26, 26290)
            case "동구":
                viewModel.fetchKindergarten(26, 26170)
            case "동래구":
                viewModel.fetchKindergarten(26, 26260)
            case "부산진구":
                viewModel.fetchKindergarten(26, 26230)
            case "북구":
                viewModel.fetchKindergarten(26, 26320)
            case "사상구":
                viewModel.fetchKindergarten(26, 26530)
            case "사하구":
                viewModel.fetchKindergarten(26, 26380)
            case "서구":
                viewModel.fetchKindergarten(26, 26140)
            case "수영구":
                viewModel.fetchKindergarten(26, 26500)
            case "연제구":
                viewModel.fetchKindergarten(26, 26470)
            case "영도구":
                viewModel.fetchKindergarten(26, 26200)
            case "중구":
                viewModel.fetchKindergarten(26, 26110)
            case "해운대구":
                viewModel.fetchKindergarten(26, 26350)
            default:
                print("부산 선택 잘못됨")
            }
            
        case "대구광역시":
            switch selectedSidogunName {
                // 대구
            case "군위군":
                viewModel.fetchKindergarten(27, 27720)
            case "남구":
                viewModel.fetchKindergarten(27, 27200)
            case "달서구":
                viewModel.fetchKindergarten(27, 27290)
            case "달성군":
                viewModel.fetchKindergarten(27, 27710)
            case "동구":
                viewModel.fetchKindergarten(27, 27140)
            case "북구":
                viewModel.fetchKindergarten(27, 27230)
            case "서구":
                viewModel.fetchKindergarten(27, 27170)
            case "수성구":
                viewModel.fetchKindergarten(27, 27260)
            case "중구":
                viewModel.fetchKindergarten(27, 27110)
            default:
                print("대구 선택 잘못됨")
            }
            
        case "인천광역시":
            switch selectedSidogunName {
                // 인천
            case "강화군":
                viewModel.fetchKindergarten(28, 28710)
            case "계양구":
                viewModel.fetchKindergarten(28, 28245)
            case "남동구":
                viewModel.fetchKindergarten(28, 28200)
            case "동구":
                viewModel.fetchKindergarten(28, 28140)
            case "미추홀구":
                viewModel.fetchKindergarten(28, 28177)
            case "부평구":
                viewModel.fetchKindergarten(28, 28237)
            case "서구":
                viewModel.fetchKindergarten(28, 28260)
            case "연수구":
                viewModel.fetchKindergarten(28, 28185)
            case "옹진군":
                viewModel.fetchKindergarten(28, 28720)
            case "중구":
                viewModel.fetchKindergarten(28, 28110)
            default:
                print("인천 선택 잘못됨")
            }
            
        case "광주광역시":
            switch selectedSidogunName {
                // 광주
            case "광산구":
                viewModel.fetchKindergarten(29, 29200)
            case "남구":
                viewModel.fetchKindergarten(29, 29155)
            case "동구":
                viewModel.fetchKindergarten(29, 29110)
            case "북구":
                viewModel.fetchKindergarten(29, 29170)
            case "서구":
                viewModel.fetchKindergarten(29, 29140)
            default:
                print("광주 선택 잘못됨")
            }
            
        case "대전광역시":
            switch selectedSidogunName {
                // 대전
            case "대덕구":
                viewModel.fetchKindergarten(30, 30230)
            case "동구":
                viewModel.fetchKindergarten(30, 30110)
            case "서구":
                viewModel.fetchKindergarten(30, 30170)
            case "유성구":
                viewModel.fetchKindergarten(30, 30200)
            case "중구":
                viewModel.fetchKindergarten(30, 30140)
            default:
                print("대전 선택 잘못됨")
            }
            
        case "울산광역시":
            switch selectedSidogunName {
                // 울산
            case "남구":
                viewModel.fetchKindergarten(31, 31140)
            case "동구":
                viewModel.fetchKindergarten(31, 31170)
            case "북구":
                viewModel.fetchKindergarten(31, 31200)
            case "울주군":
                viewModel.fetchKindergarten(31, 31710)
            case "중구":
                viewModel.fetchKindergarten(31, 31110)
            default:
                print("울산 선택 잘못됨")
            }
            
        case "세종특별자치시":
            switch selectedSidogunName {
                // 세종
            case "세종특별자치시":
                viewModel.fetchKindergarten(36, 36110)
            default:
                print("세종 선택 잘못됨")
            }
            
        case "경기도":
            switch selectedSidogunName {
                // 경기
            case "가평군":
                viewModel.fetchKindergarten(41, 41820)
            case "고양시 덕양구":
                viewModel.fetchKindergarten(41, 41281)
            case "고양시 일산동구":
                viewModel.fetchKindergarten(41, 41285)
            case "고양시 일산서구":
                viewModel.fetchKindergarten(41, 41287)
            case "과천시":
                viewModel.fetchKindergarten(41, 41290)
            case "광명시":
                viewModel.fetchKindergarten(41, 41210)
            case "광주시":
                viewModel.fetchKindergarten(41, 41610)
            case "구리시":
                viewModel.fetchKindergarten(41, 41310)
            case "군포시":
                viewModel.fetchKindergarten(41, 41410)
            case "김포시":
                viewModel.fetchKindergarten(41, 41570)
            case "남양주시":
                viewModel.fetchKindergarten(41, 41360)
            case "동두천시":
                viewModel.fetchKindergarten(41, 41250)
            case "부천시":
                viewModel.fetchKindergarten(41, 41190)
            case "성남시 분당구":
                viewModel.fetchKindergarten(41, 41135)
            case "성남시 수정구":
                viewModel.fetchKindergarten(41, 41131)
            case "성남시 중원구":
                viewModel.fetchKindergarten(41, 41133)
            case "수원시 권선구":
                viewModel.fetchKindergarten(41, 41113)
            case "수원시 영통구":
                viewModel.fetchKindergarten(41, 41117)
            case "수원시 장안구":
                viewModel.fetchKindergarten(41, 41111)
            case "수원시 팔달구":
                viewModel.fetchKindergarten(41, 41115)
            case "시흥시":
                viewModel.fetchKindergarten(41, 41390)
            case "안산시 단원구":
                viewModel.fetchKindergarten(41, 41273)
            case "안산시 상록구":
                viewModel.fetchKindergarten(41, 41271)
            case "안성시":
                viewModel.fetchKindergarten(41, 41550)
            case "안양시 동안구":
                viewModel.fetchKindergarten(41, 41173)
            case "안양시 만안구":
                viewModel.fetchKindergarten(41, 41171)
            case "양주시":
                viewModel.fetchKindergarten(41, 41630)
            case "양평군":
                viewModel.fetchKindergarten(41, 41830)
            case "여주시":
                viewModel.fetchKindergarten(41, 41670)
            case "연천군":
                viewModel.fetchKindergarten(41, 41800)
            case "오산시":
                viewModel.fetchKindergarten(41, 41370)
            case "용인시 기흥구":
                viewModel.fetchKindergarten(41, 41463)
            case "용인시 수지구":
                viewModel.fetchKindergarten(41, 41465)
            case "용인시 처인구":
                viewModel.fetchKindergarten(41, 41461)
            case "의왕시":
                viewModel.fetchKindergarten(41, 41430)
            case "의정부시":
                viewModel.fetchKindergarten(41, 41150)
            case "이천시":
                viewModel.fetchKindergarten(41, 41500)
            case "파주시":
                viewModel.fetchKindergarten(41, 41480)
            case "평택시":
                viewModel.fetchKindergarten(41, 41220)
            case "포천시":
                viewModel.fetchKindergarten(41, 41650)
            case "하남시":
                viewModel.fetchKindergarten(41, 41450)
            case "화성시":
                viewModel.fetchKindergarten(41, 41590)
            default:
                print("경기 선택 잘못됨")
            }
            
        case "강원특별자치도":
            switch selectedSidogunName {
                // 강원
            case "강릉시":
                viewModel.fetchKindergarten(51, 51150)
            case "고성군":
                viewModel.fetchKindergarten(51, 51820)
            case "동해시":
                viewModel.fetchKindergarten(51, 51170)
            case "삼척시":
                viewModel.fetchKindergarten(51, 51230)
            case "속초시":
                viewModel.fetchKindergarten(51, 51210)
            case "양구군":
                viewModel.fetchKindergarten(51, 51800)
            case "양양군":
                viewModel.fetchKindergarten(51, 51830)
            case "영월군":
                viewModel.fetchKindergarten(51, 51750)
            case "원주시":
                viewModel.fetchKindergarten(51, 51130)
            case "인제군":
                viewModel.fetchKindergarten(51, 51810)
            case "정선군":
                viewModel.fetchKindergarten(51, 51770)
            case "철원군":
                viewModel.fetchKindergarten(51, 51780)
            case "춘천시":
                viewModel.fetchKindergarten(51, 51110)
            case "태백시":
                viewModel.fetchKindergarten(51, 51190)
            case "평창군":
                viewModel.fetchKindergarten(51, 51760)
            case "홍천군":
                viewModel.fetchKindergarten(51, 51720)
            case "화천군":
                viewModel.fetchKindergarten(51, 51790)
            case "횡성군":
                viewModel.fetchKindergarten(51, 51730)
            default:
                print("강원 선택 잘못됨")
            }
            
        case "충청북도":
            switch selectedSidogunName {
                // 충북
            case "괴산군":
                viewModel.fetchKindergarten(43, 43760)
            case "단양군":
                viewModel.fetchKindergarten(43, 43800)
            case "보은군":
                viewModel.fetchKindergarten(43, 43720)
            case "영동군":
                viewModel.fetchKindergarten(43, 43740)
            case "옥천군":
                viewModel.fetchKindergarten(43, 43730)
            case "음성군":
                viewModel.fetchKindergarten(43, 43770)
            case "제천시":
                viewModel.fetchKindergarten(43, 43150)
            case "증평군":
                viewModel.fetchKindergarten(43, 43745)
            case "진천군":
                viewModel.fetchKindergarten(43, 43750)
            case "청주시 상당구":
                viewModel.fetchKindergarten(43, 43111)
            case "청주시 서원구":
                viewModel.fetchKindergarten(43, 43112)
            case "청주시 청원구":
                viewModel.fetchKindergarten(43, 43114)
            case "청주시 흥덕구":
                viewModel.fetchKindergarten(43, 43113)
            case "충주시":
                viewModel.fetchKindergarten(43, 43130)
            default:
                print("충북 선택 잘못됨")
            }
            
        case "충청남도":
            switch selectedSidogunName {
                // 충남
            case "계룡시":
                viewModel.fetchKindergarten(44, 44250)
            case "공주시":
                viewModel.fetchKindergarten(44, 44150)
            case "금산군":
                viewModel.fetchKindergarten(44, 44710)
            case "논산시":
                viewModel.fetchKindergarten(44, 44230)
            case "당진시":
                viewModel.fetchKindergarten(44, 44270)
            case "보령시":
                viewModel.fetchKindergarten(44, 44180)
            case "부여군":
                viewModel.fetchKindergarten(44, 44760)
            case "서산시":
                viewModel.fetchKindergarten(44, 44210)
            case "서천군":
                viewModel.fetchKindergarten(44, 44770)
            case "아산시":
                viewModel.fetchKindergarten(44, 44200)
            case "예산군":
                viewModel.fetchKindergarten(44, 44810)
            case "천안시 동남구":
                viewModel.fetchKindergarten(44, 44131)
            case "천안시 서북구":
                viewModel.fetchKindergarten(44, 44133)
            case "청양군":
                viewModel.fetchKindergarten(44, 44790)
            case "태안군":
                viewModel.fetchKindergarten(44, 44825)
            case "홍성군":
                viewModel.fetchKindergarten(44, 44800)
            default:
                print("충남 선택 잘못됨")
            }
            
        case "전라북도":
            switch selectedSidogunName {
                // 전북
            case "고창군":
                viewModel.fetchKindergarten(45, 45790)
            case "군산시":
                viewModel.fetchKindergarten(45, 45130)
            case "김제시":
                viewModel.fetchKindergarten(45, 45210)
            case "남원시":
                viewModel.fetchKindergarten(45, 45190)
            case "무주군":
                viewModel.fetchKindergarten(45, 45730)
            case "부안군":
                viewModel.fetchKindergarten(45, 45800)
            case "순창군":
                viewModel.fetchKindergarten(45, 45770)
            case "완주군":
                viewModel.fetchKindergarten(45, 45710)
            case "익산시":
                viewModel.fetchKindergarten(45, 45140)
            case "임실군":
                viewModel.fetchKindergarten(45, 45750)
            case "장수군":
                viewModel.fetchKindergarten(45, 45740)
            case "전주시 덕진구":
                viewModel.fetchKindergarten(45, 45113)
            case "전주시 완산구":
                viewModel.fetchKindergarten(45, 45111)
            case "정읍시":
                viewModel.fetchKindergarten(45, 45180)
            case "진안군":
                viewModel.fetchKindergarten(45, 45720)
            default:
                print("전북 선택 잘못됨")
            }
            
        case "전라남도":
            switch selectedSidogunName {
                // 전남
            case "강진군":
                viewModel.fetchKindergarten(46, 46810)
            case "고흥군":
                viewModel.fetchKindergarten(46, 46770)
            case "곡성군":
                viewModel.fetchKindergarten(46, 46720)
            case "광양시":
                viewModel.fetchKindergarten(46, 46230)
            case "구례군":
                viewModel.fetchKindergarten(46, 46730)
            case "나주시":
                viewModel.fetchKindergarten(46, 46170)
            case "담양군":
                viewModel.fetchKindergarten(46, 46710)
            case "목포시":
                viewModel.fetchKindergarten(46, 46110)
            case "무안군":
                viewModel.fetchKindergarten(46, 46840)
            case "보성군":
                viewModel.fetchKindergarten(46, 46780)
            case "순천시":
                viewModel.fetchKindergarten(46, 46150)
            case "신안군":
                viewModel.fetchKindergarten(46, 46910)
            case "여수시":
                viewModel.fetchKindergarten(46, 46130)
            case "영광군":
                viewModel.fetchKindergarten(46, 46870)
            case "영암군":
                viewModel.fetchKindergarten(46, 46830)
            case "완도군":
                viewModel.fetchKindergarten(46, 46890)
            case "장성군":
                viewModel.fetchKindergarten(46, 46880)
            case "장흥군":
                viewModel.fetchKindergarten(46, 46800)
            case "진도군":
                viewModel.fetchKindergarten(46, 46900)
            case "함평군":
                viewModel.fetchKindergarten(46, 46860)
            case "해남군":
                viewModel.fetchKindergarten(46, 46820)
            case "화순군":
                viewModel.fetchKindergarten(46, 46790)
            default:
                print("전남 선택 잘못됨")
            }
            
        case "경상북도":
            switch selectedSidogunName {
                // 경북
            case "경산시":
                viewModel.fetchKindergarten(47, 47290)
            case "경주시":
                viewModel.fetchKindergarten(47, 47130)
            case "고령군":
                viewModel.fetchKindergarten(47, 47830)
            case "구미시":
                viewModel.fetchKindergarten(47, 47190)
            case "김천시":
                viewModel.fetchKindergarten(47, 47150)
            case "문경시":
                viewModel.fetchKindergarten(47, 47280)
            case "봉화군":
                viewModel.fetchKindergarten(47, 47920)
            case "상주시":
                viewModel.fetchKindergarten(47, 47250)
            case "성주군":
                viewModel.fetchKindergarten(47, 47840)
            case "안동시":
                viewModel.fetchKindergarten(47, 47170)
            case "영덕군":
                viewModel.fetchKindergarten(47, 47770)
            case "영양군":
                viewModel.fetchKindergarten(47, 47760)
            case "영주시":
                viewModel.fetchKindergarten(47, 47210)
            case "영천시":
                viewModel.fetchKindergarten(47, 47230)
            case "예천군":
                viewModel.fetchKindergarten(47, 47900)
            case "울릉군":
                viewModel.fetchKindergarten(47, 47940)
            case "울진군":
                viewModel.fetchKindergarten(47, 47930)
            case "의성군":
                viewModel.fetchKindergarten(47, 47730)
            case "청도군":
                viewModel.fetchKindergarten(47, 47820)
            case "청송군":
                viewModel.fetchKindergarten(47, 47750)
            case "칠곡군":
                viewModel.fetchKindergarten(47, 47850)
            case "포항시 남구":
                viewModel.fetchKindergarten(47, 47111)
            case "포항시 북구":
                viewModel.fetchKindergarten(47, 47113)
            default:
                print("경북 선택 잘못됨")
            }
            
        case "경상남도":
            switch selectedSidogunName {
                // 경남
            case "거제시":
                viewModel.fetchKindergarten(48, 48310)
            case "거창군":
                viewModel.fetchKindergarten(48, 48880)
            case "고성군":
                viewModel.fetchKindergarten(48, 48820)
            case "김해시":
                viewModel.fetchKindergarten(48, 48250)
            case "남해군":
                viewModel.fetchKindergarten(48, 48840)
            case "밀양시":
                viewModel.fetchKindergarten(48, 48270)
            case "사천시":
                viewModel.fetchKindergarten(48, 48240)
            case "산청군":
                viewModel.fetchKindergarten(48, 48860)
            case "양산시":
                viewModel.fetchKindergarten(48, 48330)
            case "의령군":
                viewModel.fetchKindergarten(48, 48720)
            case "진주시":
                viewModel.fetchKindergarten(48, 48170)
            case "창녕군":
                viewModel.fetchKindergarten(48, 48740)
            case "창원시 마산합포구":
                viewModel.fetchKindergarten(48, 48125)
            case "창원시 마산회원구":
                viewModel.fetchKindergarten(48, 48127)
            case "창원시 성산구":
                viewModel.fetchKindergarten(48, 48123)
            case "창원시 의창구":
                viewModel.fetchKindergarten(48, 48121)
            case "창원시 진해구":
                viewModel.fetchKindergarten(48, 48129)
            case "통영시":
                viewModel.fetchKindergarten(48, 48220)
            case "하동군":
                viewModel.fetchKindergarten(48, 48850)
            case "함안군":
                viewModel.fetchKindergarten(48, 48730)
            case "함양군":
                viewModel.fetchKindergarten(48, 48870)
            case "합천군":
                viewModel.fetchKindergarten(48, 48890)
            default:
                print("경남 선택 잘못됨")
            }
            
        case "제주특별자치도":
            switch selectedSidogunName {
                // 제주
            case "서귀포시":
                viewModel.fetchKindergarten(50, 50130)
            case "제주시":
                viewModel.fetchKindergarten(50, 50110)
            default:
                print("제주 선택 잘못됨")
            }
            
        default:
            print("전국 선택 잘못됨")
        }
        
        
        
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
        
        
        let cellData = self.kinderInfo[indexPath.row]
        print(#fileID, #function, #line, "- cellData indexPath.row = \(cellData)")
        
        // 뷰컨트롤러 테이블뷰셀
        cell.updateUI(cellData)
        
        return cell
    }
    
    
}

extension ViewController: UITableViewDelegate {
    
}

