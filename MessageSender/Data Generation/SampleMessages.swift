//
//  Lorem.swift
//  MessageSender
//
//  Created by 백성준 on 2021/12/22.
//

import Foundation
import UIKit

struct IntervalMessage {
    let text: String
    let onTypingTimeInterval: TimeInterval
    let timeInterval: TimeInterval
    
    init(text: String, onTypingTimeInterval: TimeInterval = 2.5, timeInterval: TimeInterval = 2.5) {
        self.text = text
        self.onTypingTimeInterval = onTypingTimeInterval
        self.timeInterval = timeInterval
    }
}

public class SampleMessages {
    static let messageList: [IntervalMessage] = [
        IntervalMessage(text: "Hello, world?", onTypingTimeInterval: 1.0, timeInterval: 1),
        IntervalMessage(text: "This is Sample Message...", onTypingTimeInterval: 1.0, timeInterval: 1)
    ]
}

