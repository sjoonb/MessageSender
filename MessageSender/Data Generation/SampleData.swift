//
//  SampleData.swift
//  MessageSender
//
//  Created by 백성준 on 2021/12/22.
//


import UIKit
import MessageKit
import CoreLocation
import AVFoundation

final internal class SampleData {
    static let shared = SampleData()
    private init() {}
    
    let assistant = MockUser(senderId: "000000", displayName: "Steve Jobs")
    let user = MockUser(senderId: "000001", displayName: "User")
    
    var messageCount: Int = 0

    var timeInterval: TimeInterval {
        return SampleMessages.messageList[messageCount].timeInterval
    }
    
    var onTypingTimeInterval: TimeInterval {
        return SampleMessages.messageList[messageCount].onTypingTimeInterval
    }
    
    var waitForReply: Bool {
        return SampleMessages.messageList[messageCount].waitForReply
    }
    
    var replyText: String {
        return SampleMessages.messageList[messageCount].replyText
    }
    
    func sequenceMessage() -> MockMessage? {
        if messageCount >= SampleMessages.messageList.count {
            return nil
        }
        
        let uniqueID = UUID().uuidString
        let date = Date.init()
        let text = SampleMessages.messageList[messageCount].text

        return MockMessage(text: text, user: assistant, messageId: uniqueID, date: date)
    }
    
    func update() {
        messageCount += 1
    }
    
    func getAvatarFor(sender: SenderType) -> Avatar {
        let firstName = sender.displayName.components(separatedBy: " ").first
        let lastName = sender.displayName.components(separatedBy: " ").first
        let initials = "\(firstName?.first ?? "A")\(lastName?.first ?? "A")"
        switch sender.senderId {
        case "000000":
            return Avatar(image: #imageLiteral(resourceName: "Steve-Jobs"), initials: initials)
        case "000001":
            return Avatar(image: #imageLiteral(resourceName: "Steven-Deutsch"), initials: initials)
        default:
            return Avatar(image: nil, initials: initials)
        }
    }
    
}

