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
                self.kinderInfo.accept(kinderInfo)
                self.scrollToTop.onNext(())
                
                self.isLoading.accept(false)
            })
                .disposed(by: disposeBag)
    }
    
    
    
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
