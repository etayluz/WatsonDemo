//
//  Message.swift
//  WatsonDemo
//
//  Created by Etay Luz on 11/14/16.
//  Copyright © 2016 Etay Luz. All rights reserved.
//

import Foundation

// MARK: - Type
enum MessageType {
    case User
    case Watson
}

public struct Message {

    // MARK: - Properties
    var options: [String]?
    var text: String?
    var type: MessageType


    /// Initialize Message instance
    ///
    /// - Parameters:
    ///   - type: type of message
    ///   - text: text of message
    ///   - options: button options
    init(type: MessageType, text: String, options: [String]?) {
        self.type = type
        self.text = text
        self.options = options
    }

}
