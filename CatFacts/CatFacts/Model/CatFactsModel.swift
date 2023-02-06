//
//  CatFactsModel.swift
//  CatFacts
//
//  Created by Silvia Helena on 04/02/23.
//

import Foundation


// MARK: - CatFactsModel
struct CatFactModel: Codable {
    let status: Status
    let id, user, text: String
    let v: Int
    let source, updatedAt, type, createdAt: String
    let deleted, used: Bool

    enum CodingKeys: String, CodingKey {
        case status
        case id = "_id"
        case user, text
        case v = "__v"
        case source, updatedAt, type, createdAt, deleted, used
    }
}

// MARK: - Status
struct Status: Codable {
    let verified: Bool
    let sentCount: Int
}

typealias CatFactsModel = [CatFactModel]
