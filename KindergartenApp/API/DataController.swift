//
//  DataController.swift
//  KindergartenApp
//
//  Created by 김도훈 on 2023/10/04.
//

import Foundation

// 데이터 전달을 위한 싱글톤 객체 생성
// 어디서든 접근할 수 있는 공유 인스턴스 생성
class DataController {
    static let shared = DataController()
    
    var selectedKindergarten: KinderInfo?
    
    private init() {}
}
