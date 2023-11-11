//
//  ChatCompletion.swift
//  GIMMChat
//
//  Created by Sean McKenzie on 11/10/23.
//

import Foundation

struct ChatCompletion: Identifiable, Hashable, Codable {
    let id: String
    let choices: [Choice]
    let created: Int
    let model: String
}


