//
//  PuzzleBoard.swift
//  SlidingPuzzle
//
//  Created by Jason wang on 2/26/19.
//  Copyright © 2019 JasonWang. All rights reserved.
//

import Foundation

typealias Position = (x: Int, y: Int)
typealias Board = [[Int]]


class PuzzleBoardEngine {

    private let solvedBoard = [
        [1,2,3,4],
        [5,6,7,8],
        [9,10,11,12],
        [13,14,15,0]
    ]
    var updatedBoard = [[Int]]()

    var reloadBoard: ((Bool) ->())?

    private var randomShuffleMove = [Int]()
    private var currentBlackPosition: Position = (3, 3)

    func generateBoard() -> [[Int]] {
        
        updatedBoard = solvedBoard

        let randomMoves = Int.random(in: 3 ... 4)
        for _ in 0...randomMoves {
            // generate a valid direction
            let directions = possibleDirectionMove(blank: currentBlackPosition, in: updatedBoard)
//                        guard directions.count > 0 else { continue }
            if directions.count > 0 {
                let randomDirectionNum = Int.random(in: 0...directions.count - 1 )
                let possibleDirection = directions[randomDirectionNum]
                let position = Position(currentBlackPosition.x + possibleDirection.moveDirection().x, currentBlackPosition.y + possibleDirection.moveDirection().y)

                updatedBoard = updatedBoardWithSwap(blankPosition: currentBlackPosition, with: position, with: updatedBoard)
            }
        }


        return updatedBoard
    }



    private func possibleDirectionMove(blank: Position, in board: Board) -> [Direction] {
        var direction = [Direction]()
//        print("x: \(blank.x)   y: \(blank.y)")
//        print("is x > 0, y < \(board[0].count - 1) ")

        if blank.x > 0 {
            direction.append(.left)
        }
        if blank.y > 0 {
            direction.append(.up)
        }

        if blank.y < (board.count - 1) {
            direction.append(.down)
        }

        if blank.x < (board.count - 1) {
            direction.append(.right)
        }
        print(direction)
//        if (blank.x > 0 && (blank.x < board[0].count - 1)) {
//            direction.append(.left)
//            direction.append(.right)
//        }
//        if blank.y > 0 && blank.y < board.count - 1 {
//            direction.append(.up)
//            direction.append(.down)
//        }
        return direction
    }

    private func updatedBoardWithSwap(blankPosition: Position, with targetPosition: Position, with board: Board) -> Board {
        var motifiedBoard = board

        // get target number and replace with 0
        let targetNumber = motifiedBoard[targetPosition.x][targetPosition.y]
        motifiedBoard[targetPosition.x][targetPosition.y] = 0
        // get blankposition and replace with target number
        motifiedBoard[blankPosition.x][blankPosition.y] = targetNumber
        currentBlackPosition = Position(targetPosition.x, targetPosition.y)

        return motifiedBoard
    }

    private func didFindNeighorBlankPositionWith(current: Position) -> Position? {
        let upPosition = Position(current.x, current.y + 1)
        let downPosition = Position(current.x, current.y - 1)
        let righPosition = Position(current.x + 1, current.y)
        let leftPosition = Position(current.x - 1, current.y)

        let positions = [upPosition, downPosition, righPosition, leftPosition]
        let didFound = positions.contains(where: { (x, y) -> Bool in
            return  (x == currentBlackPosition.x && y == currentBlackPosition.y)
        })

        if didFound {
            return currentBlackPosition
        } else {
            return nil
        }
    }

    func userTappedTappedAt(_ position: Position) {
        // update board
        // swap neighbor blank position if exist
        if let swapPosition = didFindNeighorBlankPositionWith(current: position) {
            updatedBoard = updatedBoardWithSwap(blankPosition: swapPosition, with: position, with: updatedBoard)
        } else {
            print("no blank position found in neighor")
        }

        reloadBoard?(userDidWin())

    }

    private func userDidWin() -> Bool {
        return updatedBoard == solvedBoard

//        var doesMatch = true
//        for (rowIndex, row) in updatedBoard.enumerated() {
//            for (colIndex, _) in row.enumerated() {
//                if updatedBoard[rowIndex][colIndex] != solvedBoard[rowIndex][colIndex] {
//                    doesMatch = false
//                    return doesMatch
//                }
//            }
//        }
//        return doesMatch
    }

}

