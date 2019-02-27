//
//  ViewController.swift
//  SlidingPuzzle
//
//  Created by Jason wang on 2/26/19.
//  Copyright © 2019 JasonWang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var puzzleMatrix: [UIButton]!

    var buttonMatrix = [[UIButton]]()
    var boardEngin = PuzzleBoardEngine()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        boardEngin.reloadBoard = { [weak self] didWin in
            self?.updateUI()
            if didWin {
                print("You WON!")
            }
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        let board = boardEngin.generateBoard()
        print(board)

        let row1 = [puzzleMatrix[0],puzzleMatrix[1],puzzleMatrix[2],puzzleMatrix[3]]
        let row2 = [puzzleMatrix[4],puzzleMatrix[5],puzzleMatrix[6],puzzleMatrix[7]]
        let row3 = [puzzleMatrix[8],puzzleMatrix[9],puzzleMatrix[10],puzzleMatrix[11]]
        let row4 = [puzzleMatrix[12],puzzleMatrix[13],puzzleMatrix[14],puzzleMatrix[15]]
        buttonMatrix = [row1, row2,row3,row4]
        updateUI()
    }

    @objc func buttonTapped(sender: UIButton) {
        let positionTapped = getButtonPosition(selectedButton: sender)
        guard let validPosition = positionTapped, sender.tag != 0 else { return }
        print("button Tapped at position \(validPosition)")
        boardEngin.userTappedTappedAt(validPosition)

    }

    func updateUI() {
        for (xIndex, buttons) in buttonMatrix.enumerated() {
            for (yIndex, button) in buttons.enumerated() {
                let number = boardEngin.updatedBoard[xIndex][yIndex]
                button.setTitle("\(number)", for: .normal)
                button.tag = number
                button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            }
        }
    }

    private func getButtonPosition(selectedButton: UIButton) -> Position? {
        for (xIndex, buttons) in buttonMatrix.enumerated() {
            for (yIndex, button) in buttons.enumerated() {
                if button.tag == selectedButton.tag {
                    return Position(xIndex, yIndex)
                }
            }
        }
        return nil
    }


}

