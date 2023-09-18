//
//  KindergartenResponse.swift
//  KindergartenApp
//
//  Created by 김도훈 on 2023/09/05.
//

import Foundation

struct KinderInfo: Codable {
    let key: String?
    let kindercode: String?
    let officeedu: String?
    let subofficeedu: String?
    let kindername: String?
    let establish: String?
    let edate: String?
    let odate: String?
    let addr: String?
    let telno: String?
    let hpaddr: String?
    let opertime: String?
    let clcnt3: String?
    let clcnt4: String?
    let clcnt5: String?
    let mixclcnt: String?
    let shclcnt: String?
    let ppcnt3: String?
    let ppcnt4: String?
    let ppcnt5: String?
    let mixppcnt: String?
    let shppcnt: String?
    let rppnname: String?
    let ldgrname: String?
    let pbnttmng: String?
    let prmstfcnt: String?
    let ag3fpcnt: String?
    let ag4fpcnt: String?
    let ag5fpcnt: String?
    let mixfpcnt: String?
    let spcnfpcnt: String?
    
}

// MARK: - KindergartenResponse
struct KindergartenResponse: Codable {
    let status: String?
    let kinderInfo: [KinderInfo]?
}
