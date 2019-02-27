//
//  Direction.swift
//  SlidingPuzzle
//
//  Created by Jason wang on 2/26/19.
//  Copyright © 2019 JasonWang. All rights reserved.
//

import Foundation

enum Direction {
    case up
    case down
    case right
    case left

    func moveDirection() -> Position {
        switch self {
        case .up:
            return (0, -1)
        case .down:
            return (0, 1)
        case .right:
            return (1, 0)
        case .left:
            return (-1, 0)
        }
    }
}
