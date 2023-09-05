//
//  KindergartenAPI+Rx.swift
//  KindergartenApp
//
//  Created by 김도훈 on 2023/09/05.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa

extension KindergartenAPI {
    
    static func fetchKindergarten(sidoCode: Int, sggCode: Int) -> Observable<KindergartenResponse> {
        
        var baseURL = "https://e-childschoolinfo.moe.go.kr/api/notice/basicInfo2.do?"
        
        var apiKey = "key=d926d9b977504eda93848fec663b4a5d"
        
        let urlString = baseURL + apiKey + "&sidoCode=\(sidoCode)" + "&sggCode=\(sggCode)"
        
        guard let url = URL(string: urlString) else {
            return Observable.error(ApiError.notAllowedURL)
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("JSESSIONID=RCCgPpV5xYXDfKYqd3lOOL54pjqghjoUBTgOh0mQNhJE87OlxhAKYGuDOiVUaISX.ies-kirwas1_servlet_engine1; WMONID=PVXOtd8rjqZ",
                            forHTTPHeaderField: "Cookie")
        urlRequest.httpMethod = "GET"
        
        return URLSession.shared.rx
            .response(request: urlRequest)
            .map({ (urlResponse: HTTPURLResponse, data: Data) -> KindergartenResponse in
                guard let httpResponse = urlResponse as? HTTPURLResponse else {
                    print(#fileID, #function, #line, "- bad status code: ")
                    throw ApiError.unknownError(nil)
                }
                
                if !(200...299).contains(httpResponse.statusCode) {
                    throw ApiError.badStatus(httpResponse.statusCode)
                }
                
                switch httpResponse.statusCode {
                case 400:
                    throw ApiError.badRequestError
                case 204:
                    throw ApiError.noContentsError
                default:
                    print("default")
                }
                
                do {
                    let listResponse = try JSONDecoder().decode(KindergartenResponse.self, from: data)
                    let kindergartenInfo = listResponse.kinderInfo
                    
                    guard let kindergartenInfo = kindergartenInfo,
                          !kindergartenInfo.isEmpty else {
                        throw ApiError.noContentsError
                    }
                    
                    return listResponse
                    
                } catch {
                    throw ApiError.decodingError
                }

                
            })
    }
    
}
