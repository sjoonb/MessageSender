//
//  MockSocket.swift
//  MessageSender
//
//  Created by 백성준 on 2021/12/22.
//

import UIKit
import MessageKit

final class MockSocket {
    
    static var shared = MockSocket()
    
    private var timer: Timer?
    
    private var onNewMessageCode: ((MockMessage) -> Void)?
    
    private var onTypingStatusCode: (() -> Void)?
    
    private init() {}
    
    @discardableResult
    func connect() -> Self {
        disconnect()
        
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.handleTimer), userInfo: nil, repeats: false)

        return self
    }
    
    @discardableResult
    func disconnect() -> Self {
        timer?.invalidate()
        timer = nil
        onTypingStatusCode = nil
        onNewMessageCode = nil
        return self
    }
    
    @discardableResult
    func onNewMessage(code: @escaping (MockMessage) -> Void) -> Self {
        onNewMessageCode = code
        return self
    }
    
    @discardableResult
    func onTypingStatus(code: @escaping () -> Void) -> Self {
        onTypingStatusCode = code
        return self
    }
    
    @objc
    private func handleTimer() {
        if let message = SampleData.shared.sequenceMessage() {
            
            onTypingStatusCode?()
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(SampleData.shared.onTypingTimeInterval.toMilliseconds())) {
                self.onNewMessageCode?(message)
                
                self.timer?.invalidate()
                self.timer = Timer.scheduledTimer(timeInterval: SampleData.shared.timeInterval, target: self, selector: #selector(self.handleTimer), userInfo: nil, repeats: false)
                
                SampleData.shared.update()
            }
            
        } else {
            self.timer?.invalidate()
        }
    }
    
}
