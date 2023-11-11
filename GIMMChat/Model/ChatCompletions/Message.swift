//
//  ChatCompletion_Choice_Message.swift
//  GIMMChat
//
//  Created by Sean McKenzie on 11/10/23.
//

import Foundation

struct Message: Hashable, Codable {
    let content: String
    let role: String
}
