//
//  Utils.swift
//  TaskMaster
//
//  Created by Christian Altamura on 5/30/24.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Codable {
    let id: String
    let fullname: String
    let email: String
    let joined: TimeInterval
}

struct ToDoListItem: Codable, Identifiable {
    @DocumentID var id: String?
    let title: String
    var isDone: Bool
    var orderIndex: Int
    
    mutating func setDone(_ state:Bool) {
        self.isDone = state
    }
    
    func asDictionary() -> [String: Any] {
        return [
            "title": title,
            "isDone": isDone,
            "orderIndex": orderIndex
        ]
    }
}

extension Encodable {
    func asDictionary() -> [String: Any] {
        guard let data = try? JSONEncoder().encode(self) else {
            return [:]
        }
        
        do {
            let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
            return json ?? [:]
        } catch {
            return [:]
        }
    }
}
