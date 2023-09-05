//
//  KindergartenResponse.swift
//  KindergartenApp
//
//  Created by 김도훈 on 2023/09/05.
//

import Foundation

// MARK: - KindergartenResponse
struct KindergartenResponse: Codable {
    let status: String?
    let kinderInfo: [[String: String?]]?
}
