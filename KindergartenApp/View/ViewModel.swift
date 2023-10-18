//
//  ViewModel.swift
//  KindergartenApp
//
//  Created by 김도훈 on 2023/09/05.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa

class ViewModel {
    
    var kinderInfo : BehaviorRelay<[KinderInfo]> = BehaviorRelay<[KinderInfo]>(value: [])
    
    // 오류 확인용
    var notifyErrorOccured: PublishSubject<String> = PublishSubject<String>()
    
    // 초기 화면 지역선택 유도 뷰
    var induceKindergarten = BehaviorRelay(value: true)
    
    // 화면 로딩 on/off를 위한 behaviorRelay
    var isLoading = BehaviorRelay(value: false)
    
    // 지역 재선택시 테이블뷰셀 스크롤 위로 올리기
    var scrollToTop: PublishSubject<Void> = PublishSubject<Void>()
    
    var disposeBag = DisposeBag()
    
    // isLoading 재사용
    init(){
        isLoading
            .filter{ $0 == true }
            .bind(onNext: { _ in
                self.kinderInfo.accept([])
            }).disposed(by: disposeBag)
    }
    
    
    // 유치원 데이터 불러오기
    func fetchKindergarten(_ sidoCode: Int, _ ssgCode: Int) {
    
        self.isLoading.accept(true)
        self.induceKindergarten.accept(false)
        
        Observable.just(())
            .delay(RxTimeInterval.milliseconds(1000), scheduler: MainScheduler.instance)
            .flatMapLatest{ // 최신 데이터 요청, 이전 데이터 무시
                KindergartenAPI.fetchKindergarten(sidoCode: sidoCode, sggCode: ssgCode)
            }
            .do(onError: { error in
                self.handleError(error)
                print(#fileID, #function, #line, "- 뷰모델 패치 오류")
            }, onCompleted: {
                print(#fileID, #function, #line, "- 뷰모델 패치 성공")
            })
            .subscribe(onNext: { (response: KindergartenResponse) in
                guard let kinderInfo = response.kinderInfo else { return }
                // 커스텀 바인더 만들어서 정리
                self.kinderInfo.accept(kinderInfo)
                self.scrollToTop.onNext(())
                self.isLoading.accept(false)
            })
                .disposed(by: disposeBag)
    }
    
    func sigunguSelected(_ selectedSidoName: String, _ selectedSigunguName: String) {
        let allRegionsDict: [String: [String: (Int, Int)]] = [
            "서울특별시": seoulDict,
            "부산광역시": busanDict,
            "대구광역시": daeguDict,
            "인천광역시": incheonDict,
            "광주광역시": gwangjuDict,
            "대전광역시": daejeonDict,
            "울산광역시": ulsanDict,
            "세종특별자치시": sejongDict,
            "경기도": gyeonggiDict,
            "강원특별자치도": gangwonDict,
            "충청북도": chungbukDict,
            "충청남도": chungnamDict,
            "전라북도": jeonbukDict,
            "전라남도": jeonnamDict,
            "경상북도": gyeongbukDict,
            "경상남도": gyeongnamDict,
            "제주특별자치도": jejuDict
        ]
        
        let sidoDict = [seoulDict, busanDict, daeguDict, incheonDict,
                            gwangjuDict, daejeonDict, ulsanDict, sejongDict,
                            gyeonggiDict, gangwonDict, chungbukDict,
                            chungnamDict, jeonbukDict, jeonnamDict,
                            gyeongbukDict, gyeongnamDict , jejuDict]

        if let sidoDict = allRegionsDict[selectedSidoName],
           let value = sidoDict[selectedSigunguName] {
            fetchKindergarten(value.0, value .1)
        }

    }

    let seoulDict: [String: (Int, Int)] = [
        "강남구": (11, 11680),
        "강동구": (11, 11740),
        "강북구": (11, 11305),
        "강서구": (11, 11500),
        "관악구": (11, 11620),
        "광진구": (11, 11215),
        "구로구": (11, 11530),
        "금천구": (11, 11545),
        "노원구": (11, 11350),
        "도봉구": (11, 11320),
        "동대문구": (11, 11230),
        "동작구": (11, 11590),
        "마포구": (11, 11440),
        "서대문구": (11, 11410),
        "서초구": (11, 11650),
        "성동구": (11, 11200),
        "성북구": (11, 11290),
        "송파구": (11, 11710),
        "양천구": (11, 11470),
        "영등포구": (11, 11560),
        "용산구": (11, 11170),
        "은평구": (11, 11380),
        "종로구": (11, 11110),
        "중구": (11, 11140),
        "중랑구": (11, 11260)
    ]
    
    let busanDict: [String: (Int, Int)] = [
        "강서구": (26, 26440),
        "금정구": (26, 26410),
        "기장군": (26, 26710),
        "남구": (26, 26290),
        "동구": (26, 26170),
        "동래구": (26, 26260),
        "부산진구": (26, 26230),
        "북구": (26, 26320),
        "사상구": (26, 26530),
        "사하구": (26, 26380),
        "서구": (26, 26140 ),
        "수영구": (26, 26500),
        "연제구": (26, 26470),
        "영도구": (26, 26200),
        "중구": (26 ,26110),
        "해운대구": (26, 26350)
    ]
    
    let daeguDict: [String: (Int, Int)] = [
        "군위군": (27, 27720),
        "남구": (27, 27200),
        "달서구": (27, 27290),
        "달성군": (27, 27710),
        "동구": (27, 27140),
        "북구": (27, 27230),
        "서구": (27, 27170),
        "수성구": (27, 27260),
        "중구": (27, 27110)
    ]
    
    let incheonDict: [String: (Int, Int)] = [
        "강화군": (28, 28710),
        "계양구": (28, 28245),
        "남동구": (28, 28200),
        "동구": (28, 28140),
        "미추홀구": (28, 28177),
        "부평구": (28, 28237),
        "서구": (28, 28260),
        "연수구": (28, 28185),
        "옹진군": (28, 28720),
        "중구": (28, 28110)
    ]
    
    let gwangjuDict: [String: (Int, Int)] = [
        "광산구": (29, 29200),
        "남구": (29, 29155),
        "동구": (29, 29110),
        "북구": (29, 29170),
        "서구": (29, 29140)
    ]
    
    let daejeonDict: [String: (Int, Int)] = [
        "대덕구": (30, 30230),
        "동구": (30, 30110),
        "서구": (30, 30170),
        "유성구": (30, 30200),
        "중구": (30, 30140)
    ]
    
    let ulsanDict: [String: (Int, Int)] = [
        "남구": (31, 31140),
        "동구": (31 ,31170),
        "북구": (31, 31200),
        "울주군": (31, 31710),
        "중구": (31, 31110)
    ]
    
    let sejongDict: [String: (Int, Int)] = [
        "세종특별자치시": (36, 36110)
    ]
    
    let gyeonggiDict: [String: (Int, Int)] = [
        "가평군": (41, 41820),
        "고양시 덕양구": (41, 41281),
        "고양시 일산동구": (41, 41285),
        "고양시 일산서구": (41, 41287),
        "과천시": (41, 41290),
        "광명시": (41, 41210),
        "광주시": (41, 41610),
        "구리시": (41, 41310),
        "군포시": (41, 41410),
        "김포시": (41, 41570),
        "남양주시": (41, 41360),
        "동두천시": (41, 41250),
        "부천시": (41, 41190),
        "성남시 분당구": (41, 41135),
        "성남시 수정구": (41, 41131),
        "성남시 중원구": (41, 41133),
        "수원시 권선구": (41, 41113),
        "수원시 영통구": (41, 41117),
        "수원시 장안구": (41, 41111),
        "수원시 팔달구": (41, 41115),
        "시흥시": (41, 41390),
        "안산시 단원구": (41, 41273),
        "안산시 상록구": (41, 41271),
        "안성시": (41, 41550),
        "안양시 동안구": (41, 41173),
        "안양시 만안구": (41, 41171),
        "양주시": (41, 41630),
        "양평군": (41, 41830),
        "여주시": (41, 41670),
        "연천군": (41 ,41800),
        "오산시": (41 ,41370),
        "용인시 기흥구": (41 ,41463),
        "용인시 수지구": (41 ,41465),
        "용인시 처인구": (41, 41461),
        "의왕시": (41, 41430),
        "의정부시": (41, 41150),
        "이천시": (41, 41500),
        "파주시": (41, 41480),
        "평택시": (41 ,41220),
        "포천시": (41 ,41650),
        "하남시": (41 ,41450),
        "화성시": (41 ,41590)
    ]
    
    let gangwonDict: [String: (Int, Int)] = [
        "강릉시": (51, 51150),
        "고성군": (51 ,51820),
        "동해시": (51 ,51170),
        "삼척시": (51 ,51230),
        "속초시": (51 ,51210),
        "양구군": (51, 51800),
        "양양군": (51, 51830),
        "영월군": (51, 51750),
        "원주시": (51, 51130),
        "인제군": (51, 51810),
        "정선군": (51 ,51770),
        "철원군": (51 ,51780),
        "춘천시": (51 ,51110),
        "태백시": (51 ,51190),
        "평창군": (51 ,51760),
        "홍천군": (51, 51720),
        "화천군": (51, 51790),
        "횡성군": (51, 51730)
    ]
    
    let chungbukDict: [String: (Int, Int)] = [
        "괴산군": (43, 43760),
        "단양군": (43, 43800),
        "보은군": (43, 43720),
        "영동군": (43, 43740),
        "옥천군": (43, 43730),
        "음성군": (43, 43770),
        "제천시": (43, 43150),
        "증평군": (43, 43745),
        "진천군": (43, 43750),
        "청주시 상당구": (43, 43111),
        "청주시 서원구": (43, 43112),
        "청주시 청원구": (43, 43114),
        "청주시 흥덕구": (43, 43113),
        "충주시": (43, 43130)
    ]
    
    let chungnamDict: [String: (Int, Int)] = [
        "계룡시": (44, 44250),
        "공주시": (44, 44150),
        "금산군": (44, 44710),
        "논산시": (44, 44230),
        "당진시": (44, 44270),
        "보령시": (44, 44180),
        "부여군": (44, 44760),
        "서산시": (44, 44210),
        "서천군": (44, 44770),
        "아산시": (44, 44200),
        "예산군": (44, 44810),
        "천안시 동남구": (44, 44131),
        "천안시 서북구": (44, 44133),
        "청양군": (44, 44790),
        "태안군": (44, 44825),
        "홍성군": (44, 44800)
    ]
    
    let jeonbukDict: [String: (Int, Int)] = [
        "고창군": (45, 45790),
        "군산시": (45, 45130),
        "김제시": (45, 45210),
        "남원시": (45, 45190),
        "무주군": (45, 45730),
        "부안군": (45, 45800),
        "순창군": (45, 45770),
        "완주군": (45, 45710),
        "익산시": (45, 45140),
        "임실군": (45, 45750),
        "장수군": (45, 45740),
        "전주시 덕진구": (45, 45113),
        "전주시 완산구": (45, 45111),
        "정읍시": (45, 45180),
        "진안군": (45, 45720)
    ]
    
    let jeonnamDict: [String: (Int, Int)] = [
        "강진군": (46, 46810),
        "고흥군": (46, 46770),
        "곡성군": (46, 46720),
        "광양시": (46, 46230),
        "구례군": (46, 46730),
        "나주시": (46, 46170),
        "담양군": (46, 46710),
        "목포시": (46, 46110),
        "무안군": (46, 46840),
        "보성군": (46, 46780),
        "순천시": (46, 46150),
        "신안군": (46, 46910),
        "여수시": (46, 46130),
        "영광군": (46, 46870),
        "영암군": (46, 46830),
        "완도군": (46, 46890),
        "장성군": (46, 46880),
        "장흥군": (46, 46800),
        "진도군": (46, 46900),
        "함평군": (46, 46860),
        "해남군": (46, 46820),
        "화순군": (46, 46790)
    ]
    
    let gyeongbukDict: [String: (Int, Int)] = [
        "경산시": (47, 47290),
        "경주시": (47, 47130),
        "고령군": (47, 47830),
        "구미시": (47, 47190),
        "김천시": (47, 47150),
        "문경시": (47, 47280),
        "봉화군": (47, 47920),
        "상주시": (47, 47250),
        "성주군": (47, 47840),
        "안동시": (47, 47170),
        "영덕군": (47, 47770),
        "영양군": (47, 47760),
        "영주시": (47, 47210),
        "영천시": (47, 47230),
        "예천군":  (47, 47900),
        "울릉군": (47, 47940),
        "울진군": (47, 47930),
        "의성군": (47, 47730),
        "청도군": (47, 47820),
        "청송군": (47, 47750),
        "칠곡군": (47, 47850),
        "포항시 남구": (47, 47111),
        "포항시 북구": (47, 47113)
    ]
    
    let gyeongnamDict: [String: (Int, Int)] = [
        "거제시": (48, 48310),
        "거창군": (48, 48880),
        "고성군": (48, 48820),
        "김해시": (48, 48250),
        "남해군": (48, 48840),
        "밀양시": (48, 48270),
        "사천시": (48, 48240),
        "산청군": (48, 48860),
        "양산시": (48, 48330),
        "의령군": (48, 48720),
        "진주시": (48 ,48170 ),
        "창녕군": (48 ,48740 ),
        "창원시 마산합포구": (48 ,48125 ),
        "창원시 마산회원구": (48 ,48127 ),
        "창원시 성산구": (48, 48123),
        "창원시 의창구": (48, 48121),
        "창원시 진해구": (48, 48129),
        "통영시": (48, 48220),
        "하동군": (48, 48850),
        "함안군": (48, 48730),
        "함양군": (48, 48870),
        "합천군": (48, 48890)
    ]
    
    let jejuDict: [String: (Int, Int)] = [
        "서귀포시": (50, 50130),
        "제주시": (50, 50110)
    ]
    
    
    fileprivate func handleError(_ error: Error) {
        
        guard let apiError = error as? KindergartenAPI.ApiError else {
            print("모르는 에러입니다")
            return
        }
        
        print("handleError: Error: \(apiError.info)")
        
        switch apiError {
        case .noContentsError:
            print("컨텐츠 없음")
        case .unauthorizedError:
            print("인증 안됨")
        case .decodingError:
            print("디코딩 에러")
        case .errorResponseFromServer:
            print("서버에서 온 에러: \(apiError.info)")
            self.notifyErrorOccured.onNext(apiError.info)
        default:
            print("default")
            
        }
    }// handleError
    
}

////MARK: - 커스텀 바인더
//extension Reactive where Base: ViewModel {
//    var kinderInfo: Binder<KinderInfo> {
//        return Binder(self.base) { viewModel, kinderInfo in
//            viewModel.kinderInfo.accept(kinderInfo)
//        }
//    }
//
//    var scrollToTop: Binder<Void> {
//        return Binder(self.base) { viewModel, _ in
//            viewModel.scrollToTop.onNext(())
//        }
//    }
//
//    var isLoading: Binder<Bool> {
//        return Binder(self.base) { viewModel, isLoading in
//            viewModel.isLoading.accept(isLoading)
//        }
//    }
//}
