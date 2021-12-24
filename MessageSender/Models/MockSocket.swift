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
    
    private var onNewButtonCode: ((UIButton) -> Void)?
    
    private var onButtonTappedCode: ((MockMessage) -> Void)?
    
    lazy var replyButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 16
        button.backgroundColor = .primaryColor
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(UIColor(white: 1, alpha: 0.3), for: .highlighted)
        return button
    }()
 
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
    
    @discardableResult
    func onNewButton(code: @escaping (UIButton) -> Void) -> Self {
        onNewButtonCode = code
        return self
    }
    
    @discardableResult
    func onButtonTapped(code: @escaping (MockMessage) -> Void) -> Self {
        onButtonTappedCode = code
        return self
    }
    
    
    @objc
    private func handleTimer() {
        guard let message = SampleData.shared.sequenceMessage() else { timer?.invalidate(); return }
            
        onTypingStatusCode?()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(SampleData.shared.onTypingTimeInterval.toMilliseconds())) {
            self.onNewMessageCode?(message)
            
            if(SampleData.shared.waitForReply) {
                self.replyButton.setTitle(SampleData.shared.replyText, for: .normal)
                self.replyButton.addTarget(self, action: #selector(self.buttonTapped), for: .touchUpInside)
                self.onNewButtonCode?(self.replyButton)
                
            } else {
                self.resetTimer()
            }
        }
    }
    
    @objc
    private func buttonTapped() {
        let message = MockMessage(text: SampleData.shared.replyText, user: SampleData.shared.user, messageId: UUID().uuidString, date: Date())
        onButtonTappedCode?(message)
        resetTimer()
    }
    
    private func resetTimer() {
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(timeInterval: SampleData.shared.timeInterval, target: self, selector: #selector(self.handleTimer), userInfo: nil, repeats: false)
        
        SampleData.shared.update()
    }
    
 
}
