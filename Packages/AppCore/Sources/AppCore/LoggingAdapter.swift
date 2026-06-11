//
//  LoggingAdapter.swift
//  AppCore
//
//  Created by Ives Murillo on 6/10/26.
//

import Logging
import PlatformContracts

final class LoggingAdapter: PlatformContracts.Logging {
    private let logger: Logger

    init(logger: Logger) {
        self.logger = logger
    }

    func log(_ string: String) {
        logger.log(LogEntry(message: string))
    }
}
