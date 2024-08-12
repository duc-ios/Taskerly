//
//  String+Extensions.swift
//  Taskerly
//
//  Created by Duc on 12/8/24.
//

import Foundation

extension String {
    var trimmed: String { trimmingCharacters(in: .whitespacesAndNewlines) }
    var isBlank: Bool { trimmed.isEmpty }
}

extension Optional<String> {
    var isNilOrBlank: Bool { (self ?? "").isBlank }
}
