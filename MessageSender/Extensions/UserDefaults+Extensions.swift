//
//  UserDefaults+Extensions.swift
//  MessageSender
//
//  Created by 백성준 on 2021/12/22.
//

import Foundation

extension UserDefaults {
    
    static let messagesKey = "mockMessages"
    
    // MARK: Mock Messages
    
    func mockMessagesCount() -> Int {
        if let value = object(forKey: UserDefaults.messagesKey) as? Int {
            return value
        }
        return 20
    }
    
    static func isFirstLaunch() -> Bool {
        let hasBeenLaunchedBeforeFlag = "hasBeenLaunchedBeforeFlag"
        let isFirstLaunch = !UserDefaults.standard.bool(forKey: hasBeenLaunchedBeforeFlag)
        if isFirstLaunch {
            UserDefaults.standard.set(true, forKey: hasBeenLaunchedBeforeFlag)
            UserDefaults.standard.synchronize()
        }
        return isFirstLaunch
    }

}
