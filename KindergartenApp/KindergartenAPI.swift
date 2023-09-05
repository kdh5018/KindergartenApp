//
//  KindergartenAPI.swift
//  KindergartenApp
//
//  Created by 김도훈 on 2023/09/05.
//

import Foundation

enum KindergartenAPI{
    
    enum ApiError: Error {
        
        case decodingError // 디코딩 에러
        case noContentsError // 찾는 컨텐츠 없음
        case unauthorizedError // 인증 에러
        case unknownError(_ err: Error?) // 알 수 없는 오류
        case badStatus(_ code: Int?) // 상태 코드 에러
        case notAllowedURL // 올바른 URL 형식 아님
        case badRequestError // 요청 에러
        case jsonDecodingError // JSON 디코딩 에러
        
        var info: String {
            switch self {
            case .noContentsError:                              return "컨텐츠가 없습니다."
            case .decodingError:                                return "디코딩 에러입니다."
            case .unauthorizedError:                            return "인증되지 않은 사용자입니다."
            case let .badStatus(code):                          return "에러 상태코드: \(code)"
            case .unknownError(let err):                        return "알 수 없는 오류입니다: \(err)"
            case .notAllowedURL:                                return "올바른 URL 형식이 아닙니다."
            case .badRequestError:                              return "잘못된 요청입니다."
            case .jsonDecodingError:                            return "JSON 디코딩 에러입니다."
            }
            
        }
        
    }
}
