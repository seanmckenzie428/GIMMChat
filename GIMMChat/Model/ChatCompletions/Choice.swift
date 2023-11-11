//
//  ChatCompletion_Choice.swift
//  GIMMChat
//
//  Created by Sean McKenzie on 11/10/23.
//

import Foundation

struct Choice: Hashable, Codable {
    let finishReason: String
    let index: Int
    let message: Message

    enum CodingKeys: String, CodingKey {
        case finishReason = "finish_reason"
        case index = "index"
        case message = "message"
    }
}
