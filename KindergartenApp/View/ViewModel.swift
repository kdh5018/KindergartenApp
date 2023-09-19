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
    
    var notifySearchDataNotFound: PublishSubject<Bool> = PublishSubject<Bool>()
    
    var notifyErrorOccured: PublishSubject<String> = PublishSubject<String>()
    
    var notifyRefreshEnded: PublishSubject<Void> = PublishSubject<Void>()
    
    var induceKindergarten: PublishSubject<Bool> = PublishSubject<Bool>()
    
    var disposeBag = DisposeBag()
    
    var kinderInfo : BehaviorRelay<[KinderInfo]> = BehaviorRelay<[KinderInfo]>(value: [])
    
    init() {
//        KindergartenAPI.fetchKindergarten(sidoCode: 27, sggCode: 27140)
//            .observe(on: MainScheduler.instance)
//            .withUnretained(self)
//            .subscribe(onNext: { vm, result in
//                print(#fileID, #function, #line, "- result: \(result)")
//            })
//            .disposed(by: disposeBag)
    }
    
    func fetchKindergarten(_ sidoCode: Int, _ ssgCode: Int) {
        
        Observable.just(())
            .delay(RxTimeInterval.milliseconds(700), scheduler: MainScheduler.instance)
            .flatMapLatest{
                KindergartenAPI.fetchKindergarten(sidoCode: sidoCode, sggCode: ssgCode)
            }
            .do(onError: { error in
                self.handleError(error)
                print(#fileID, #function, #line, "- 뷰모델 패치 오류")
            }, onCompleted: {
                self.notifyRefreshEnded.onNext(())
                print(#fileID, #function, #line, "- 뷰모델 패치 성공")
            })
            .subscribe(onNext: { (response: KindergartenResponse) in
                guard let kinderInfo = response.kinderInfo else { return }
                self.kinderInfo.accept(kinderInfo)
                print(#fileID, #function, #line, "- kinderInfo: \(kinderInfo)")
            }).disposed(by: disposeBag)
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
            self.notifySearchDataNotFound.onNext(true)
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
