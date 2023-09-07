//
//  ReuseIdentifiable.swift
//  KindergartenApp
//
//  Created by 김도훈 on 2023/09/05.
//

import Foundation
import UIKit


protocol ReuseIdentifiable {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifiable {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}

extension UITableViewCell: ReuseIdentifiable { }
