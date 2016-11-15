//
//  ConversationService.swift
//  WatsonDemo
//
//  Created by Etay Luz on 11/15/16.
//  Copyright © 2016 Etay Luz. All rights reserved.
//


import ConversationV1

protocol ConversationServiceDelegate: class {
    func conversationDidStart(withMessage:String)
}

class ConversationService {

    // MARK: - Properties
    weak var delegate: ConversationServiceDelegate?

    // save context to continue conversation
    var context: Context?
    let conversation = Conversation(username: GlobalConstants.username,
                                    password: GlobalConstants.password,
                                    version: GlobalConstants.version)

    // MARK: - Init
    init(delegate: ConversationServiceDelegate) {
        self.delegate = delegate
        conversation.serviceURL = "http://Node-Workflow-Hub.mybluemix.net/mobileV2-1"
    }

    func startConversation() {
        let failure = { (error: Error) in
            print(error)
        }

        conversation.message(withWorkspace: "", failure: failure) { [weak self] response in
            guard let strongSelf = self else { return }
            strongSelf.context = response.context
            print(response.output.text)
            strongSelf.delegate?.conversationDidStart(withMessage: "")
        }
    }

    func continueConversation(withText text:String) {
        let text = "Turn on the radio."
        let failure = { (error: Error) in print(error) }
        let request = MessageRequest(text: text, context: context)
        conversation.message(withWorkspace: GlobalConstants.workspaceID, request: request, failure: failure) { [weak self] response in
            guard let strongSelf = self else { return }

            print(response.output.text)
            strongSelf.context = response.context
        }
    }

}
