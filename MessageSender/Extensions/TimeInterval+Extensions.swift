//
//  Double+Extensions.swift
//  MessageSender
//
//  Created by 백성준 on 2021/12/24.
//

import Foundation

extension TimeInterval {
    func toMilliseconds() -> Int {
        return Int(self * 1000)
    }
}
