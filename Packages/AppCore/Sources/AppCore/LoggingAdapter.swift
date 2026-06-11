//
//  LoggingAdapter.swift
//  AppCore
//
//  Created by Ives Murillo on 6/10/26.
//

import Logging

final class LoggingAdapter {

    private let logger: Logger

    init(logger: Logger) {
        self.logger = logger
    }

    func log(_ string: String) {
        logger.log(LogEntry(message: string))
    }
}
