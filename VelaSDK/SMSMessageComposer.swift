//
//  MessageComposer.swift
//  VelaSDK
//
//  Created by Igbalajobi Elias on 12/9/18.
//  Copyright © 2018 Igbalajobi Elias. All rights reserved.
//

import Foundation
import MessageUI


public class SMSMessageComposer {
    private var textMessageRecipients = [String]()
    private var message: String!
    private var delegate: MFMessageComposeViewControllerDelegate!
    
    private var messageComposeVC: MFMessageComposeViewController!
    
    private func canSendText() -> Bool {
        return MFMessageComposeViewController.canSendText()
    }
    
    private func configuredMessageComposeViewController(delegate: MFMessageComposeViewControllerDelegate?) -> MFMessageComposeViewController {
        messageComposeVC = MFMessageComposeViewController()
        messageComposeVC.messageComposeDelegate = delegate
        messageComposeVC.recipients = textMessageRecipients
        messageComposeVC.body = message
        return messageComposeVC
    }
    
    public func present(viewController: UIViewController, onFailed: @escaping ()->Bool = {return true}){
        if (self.canSendText()) {
            let messageComposeVC = self.configuredMessageComposeViewController(delegate: delegate)
            viewController.present(messageComposeVC, animated: true, completion: nil)
        } else {
            let showErrorMessage = onFailed()
            if showErrorMessage{
                let errorAlert = UIAlertController(title: "Alert", message: APPMessages.MESSAGING_APP_NOT_AVAILABLE, preferredStyle: .alert)
                
                errorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler:{ action in
                    if action.style == .default{
                        errorAlert.dismiss(animated: true, completion: nil)
                    }
                }));
                viewController.present(errorAlert, animated: true, completion: nil)
            }
        }
    }
    
    public init(_ message: String, _ recipient: String, _ delegate: MFMessageComposeViewControllerDelegate){
        self.textMessageRecipients = [recipient]
        self.message = message
        self.delegate = delegate
    }
}
