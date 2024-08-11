//
//  TaskItem.swift
//  Taskerly
//
//  Created by Duc on 9/8/24.
//

import Foundation
import SwiftData

@Model
final class TaskItem {
    enum Priority: Int, CaseIterable, Codable, ToStringProtocol {
        case none, low, medium, high
        func toString() -> String {
            switch self {
            case .none:
                return "None"
            case .low:
                return "Low"
            case .medium:
                return "Medium"
            case .high:
                return "High"
            }
        }
    }

    enum Status: Int, CaseIterable, Codable, ToStringProtocol {
        case pending, completed

        func toString() -> String {
            switch self {
            case .pending:
                return "Pending"
            case .completed:
                return "Completed"
            }
        }
    }

    enum Reminder: Int, CaseIterable, Codable, ToStringProtocol {
        case none = 0, onTime, fiveMinutes = 5, tenMinutes = 10, oneHour = 60, oneDay = 1_440

        func toString() -> String {
            switch self {
            case .none:
                return "None"
            case .onTime:
                return "On time"
            case .fiveMinutes:
                return "5 minutes before"
            case .tenMinutes:
                return "10 minutes before"
            case .oneHour:
                return "1 hour before"
            case .oneDay:
                return "1 day before"
            }
        }
    }

    @Attribute(.unique) let id: String
    var timestamp: Date
    var name: String
    var desc: String
    var rawCategory: String
    var category: TaskCategory { TaskCategory(rawValue: rawCategory) ?? .personal }
    var rawPriority: Int
    var priority: Priority { Priority(rawValue: rawPriority) ?? .medium }
    var rawStatus: Int
    var status: Status { Status(rawValue: rawStatus) ?? .pending }
    var rawReminder: Int
    var reminder: Reminder { Reminder(rawValue: rawStatus) ?? .none }
    var order: Int

    init(id: String = UUID().uuidString,
         timestamp: Date = Date(),
         name: String = "",
         desc: String = "",
         category: TaskCategory = .personal,
         priority: Priority = .medium,
         status: Status = .pending,
         reminder: Reminder = .none,
         order: Int = 0) {
        self.id = id
        self.timestamp = timestamp
        self.name = name
        self.desc = desc
        self.rawCategory = category.rawValue
        self.rawPriority = priority.rawValue
        self.rawStatus = status.rawValue
        self.rawReminder = reminder.rawValue
        self.order = order
    }
}

extension Optional: ToStringProtocol where Wrapped == TaskItem.Status {
    func toString() -> String {
        switch self {
        case nil:
            "All"
        case .pending:
            "Pending"
        case .completed:
            "Completed"
        }
    }
}

// extension TaskItem: Codable {
//    enum CodingKeys: CodingKey {
//        case timestamp,
//             name,
//             desc,
//             category,
//             priority,
//             status,
//             reminder,
//             order
//    }
//
//    convenience init(from decoder: Decoder) throws {
//        self.init()
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        timestamp = try container.decode(Date.self, forKey: .timestamp)
//        name = try container.decode(String.self, forKey: .name)
//        desc = try container.decode(String.self, forKey: .desc)
//        rawCategory = try container.decode(String.self, forKey: .category)
//        rawPriority = try container.decode(Int.self, forKey: .priority)
//        rawStatus = try container.decode(Int.self, forKey: .status)
//        rawReminder = try container.decode(Int.self, forKey: .reminder)
//        order = try container.decode(Int.self, forKey: .order)
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(timestamp, forKey: .timestamp)
//        try container.encode(name, forKey: .name)
//        try container.encode(desc, forKey: .desc)
//        try container.encode(rawCategory, forKey: .category)
//        try container.encode(rawPriority, forKey: .priority)
//        try container.encode(rawStatus, forKey: .status)
//        try container.encode(rawReminder, forKey: .reminder)
//        try container.encode(order, forKey: .order)
//    }
// }

enum TaskCategory: Codable {
    case personal, work, custom(String)
}

extension TaskCategory: RawRepresentable, ToStringProtocol {
    init?(rawValue: String) {
        switch rawValue {
        case "Personal": self = .personal
        case "Work": self = .work
        case let string: self = .custom(string)
        }
    }

    var rawValue: RawValue {
        toString()
    }

    func toString() -> String {
        switch self {
        case .personal:
            return "Personal"
        case .work:
            return "Work"
        case .custom(let string):
            return string
        }
    }
}
