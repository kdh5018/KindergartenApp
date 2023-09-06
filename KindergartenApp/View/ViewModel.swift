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

class ViewModel: ObservableObject {
    
    var disposeBag = DisposeBag()
    
    init() {
        KindergartenAPI.fetchKindergarten(sidoCode: 27, sggCode: 27140)
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .subscribe(onNext: { vm, result in
                print(#fileID, #function, #line, "- result: \(result)")
            })
            .disposed(by: disposeBag)
    }
    
}
