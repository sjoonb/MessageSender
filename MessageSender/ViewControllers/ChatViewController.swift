/*
MIT License

Copyright (c) 2017-2020 MessageKit

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

import UIKit
import MessageKit
import InputBarAccessoryView

/// A base class for the example controllers
class ChatViewController: MessagesViewController, MessagesDataSource {

    // MARK: - Public properties

    lazy var messageList: [MockMessage] = []


    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureMessageCollectionView()
        messageInputBar.isHidden = true
        
        loadFirstMessages()
        title = "MessageKit"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        MockSocket.shared.connect(with: [SampleData.shared.nathan, SampleData.shared.wu])
            .onNewMessage { [weak self] message in
                self?.setTypingIndicatorViewHidden(true, performUpdates: {
                    self?.insertMessage(message)
                })
            }.onTypingStatus { [weak self] in
                self?.setTypingIndicatorViewHidden(false)
            }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        MockSocket.shared.disconnect()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func loadFirstMessages() {
        DispatchQueue.global(qos: .userInitiated).async {
            let count = UserDefaults.standard.mockMessagesCount()
            SampleData.shared.getMessages(count: count) { messages in
                DispatchQueue.main.async {
                    self.messageList = messages
                    self.messagesCollectionView.reloadData()
                    self.messagesCollectionView.scrollToLastItem()
                }
            }
        }
    }
    
    func configureMessageCollectionView() {
        
        messagesCollectionView.messagesDataSource = self
        
        scrollsToLastItemOnKeyboardBeginsEditing = true // default false
        maintainPositionOnKeyboardFrameChanged = true // default false
    }
    
    
    // MARK: - Helpers
    
    func insertMessage(_ message: MockMessage) {
        messageList.append(message)
        // Reload last section to update header/footer labels and insert a new one
        messagesCollectionView.performBatchUpdates({
            messagesCollectionView.insertSections([messageList.count - 1])
            if messageList.count >= 2 {
                messagesCollectionView.reloadSections([messageList.count - 2])
            }
        }, completion: { [weak self] _ in
            if self?.isLastSectionVisible() == true {
                self?.messagesCollectionView.scrollToLastItem(animated: true)
            }
        })
    }
    
    func isLastSectionVisible() -> Bool {
        
        guard !messageList.isEmpty else { return false }
        
        let lastIndexPath = IndexPath(item: 0, section: messageList.count - 1)
        
        return messagesCollectionView.indexPathsForVisibleItems.contains(lastIndexPath)
    }

    // MARK: - MessagesDataSource

    func currentSender() -> SenderType {
        return SampleData.shared.currentSender
    }

    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messageList.count
    }

    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messageList[indexPath.section]
    }
    
    func messageTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        let name = message.sender.displayName
        return NSAttributedString(string: name, attributes: [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .caption1)])
    }
    
    func textCell(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UICollectionViewCell? {
        return nil
    }
    
    func setTypingIndicatorViewHidden(_ isHidden: Bool, performUpdates updates: (() -> Void)? = nil) {
        setTypingIndicatorViewHidden(isHidden, animated: true, whilePerforming: updates) { [weak self] success in
            if success, self?.isLastSectionVisible() == true {
                self?.messagesCollectionView.scrollToLastItem(animated: true)
            }
        }
    }
}
