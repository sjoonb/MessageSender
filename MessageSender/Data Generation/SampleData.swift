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
    
    let sender = MockUser(senderId: "000000", displayName: "Steve Jobs")
    
    var messageCount: Int = 0

    var timeInterval: TimeInterval {
        return SampleMessages.messageList[messageCount].timeInterval
    }
    
    var onTypingTimeInterval: TimeInterval {
        return SampleMessages.messageList[messageCount].onTypingTimeInterval
    }
    
    func sequenceMessage() -> MockMessage? {
        if messageCount >= SampleMessages.messageList.count {
            return nil
        }
        
        let uniqueID = UUID().uuidString
        let date = Date.init()
        let text = SampleMessages.messageList[messageCount].text

        return MockMessage(text: text, user: sender, messageId: uniqueID, date: date)
    }
    
    func update() {
        messageCount += 1
    }
    
    func getAvatar() -> Avatar {
        let firstName = sender.displayName.components(separatedBy: " ").first
        let lastName = sender.displayName.components(separatedBy: " ").first
        let initials = "\(firstName?.first ?? "A")\(lastName?.first ?? "A")"
     
        let image = UIImage(named: "Steve-Jobs")
        return Avatar(image: image, initials: initials)
    }
    
}

