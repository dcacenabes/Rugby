//
//  WrapError.swift
//  
//
//  Created by Vyacheslav Khorkov on 27.02.2021.
//

import Foundation

enum WrappedError: Error, LocalizedError {
    case common(String)

    var errorDescription: String? {
        switch self {
        case .common(let description):
            return description
        }
    }

    static func wrap(playBell: Bool, _ block: () throws -> Void) throws {
        let begin = ProcessInfo.processInfo.systemUptime
        defer {
            let time = ProcessInfo.processInfo.systemUptime - begin
            if playBell && time > 1 { playBellSound() }
        }
        do {
            try block()
        } catch {
            throw WrappedError.common(error.localizedDescription.red)
        }
    }
}
