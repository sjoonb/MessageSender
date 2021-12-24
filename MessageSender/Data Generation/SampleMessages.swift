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
    let waitForReply: Bool
    let replyText: String
    
    init(text: String, onTypingTimeInterval: TimeInterval = 2.5, timeInterval: TimeInterval = 2.5, waitForReply: Bool = false, replyText: String = "Okay") {
        self.text = text
        self.onTypingTimeInterval = onTypingTimeInterval
        self.timeInterval = timeInterval
        self.waitForReply = waitForReply
        self.replyText = replyText
    }
}

public class SampleMessages {
    static let messageList: [IntervalMessage] = [
        IntervalMessage(text: "Hello, world?", onTypingTimeInterval: 1.0, timeInterval: 2, waitForReply: true, replyText: "Hello, assitant!"),
        IntervalMessage(text: "This is Sample Message...", onTypingTimeInterval: 1.0, timeInterval: 1),
    ]
    
}

