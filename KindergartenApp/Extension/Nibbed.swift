//
//  Nibbed.swift
//  KindergartenApp
//
//  Created by 김도훈 on 2023/09/05.
//

import Foundation
import UIKit


protocol Nibbed {
    static var uinib: UINib { get }
}

extension Nibbed {
    static var uinib: UINib {
        return UINib(nibName: String(describing: Self.self), bundle: nil)
    }
}

extension UITableViewCell: Nibbed { }
