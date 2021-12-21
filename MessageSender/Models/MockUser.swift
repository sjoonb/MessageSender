//
//  MockUser.swift
//  MessageSender
//
//  Created by 백성준 on 2021/12/22.
//

import Foundation
import MessageKit

struct MockUser: SenderType, Equatable {
    var senderId: String
    var displayName: String
}
