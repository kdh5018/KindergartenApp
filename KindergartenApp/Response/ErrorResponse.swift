//
//  ErrorResponse.swift
//  KindergartenApp
//
//  Created by 김도훈 on 2023/09/18.
//

import Foundation

struct ErrorResponse: Codable {
    let message: String?
}

enum MenuError: Error {
    case invalidDefaultSelection(String)
}

func validateMenuDefaultSelection(_ menu: [String]) throws {
    // 만약 메뉴가 비어 있다면, 에러를 던집니다.
    if menu.isEmpty {
        throw MenuError.invalidDefaultSelection("Menu does not have a valid element for default selection")
    }
    
}
