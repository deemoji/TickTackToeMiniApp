//
//  TickTackToeLogic.swift
//  
//
//  Created by Дмитрий Мартьянов on 07.09.2024.
//

import Foundation


class TickTackToeLogic {
    
    var endGameClosure: ((String) -> Void)?
    private(set) var currentPlayer = "❎"
    private(set) var xWins = 0
    private(set) var oWins = 0
    
    private let winCombinations = [
        [0, 1, 2], [3, 4, 5], [6, 7, 8],
        [0, 3, 6], [1, 4, 7], [2, 5, 8],
        [0, 4, 8], [2, 4, 6]
    ]
    
    private var currentBoard = [String](repeating: "", count: 9)
    
    func makeStepAt(index: Int) {
        guard index >= 0, index < currentBoard.count, currentBoard[index] == "" else { return }
        
        currentBoard[index] = currentPlayer
        if checkWin() {
            updateScore(for: currentPlayer)
            endGameClosure?("\(currentPlayer) выиграл!")
        } else if currentBoard.allSatisfy({ !$0.isEmpty }) {
            endGameClosure?("Ничья!")
        } else {
            changePlayer()
        }
    }
    
    private func updateScore(for player: String) {
        if player == "❎" {
            xWins += 1
        } else {
            oWins += 1
        }
    }
    
    private func checkWin() -> Bool {
        for combination in winCombinations {
            let first = currentBoard[combination[0]]
            if !first.isEmpty && combination.allSatisfy({ currentBoard[$0] == first }) {
                return true
            }
        }
        return false
    }
    
    private func changePlayer() {
        currentPlayer = (currentPlayer == "❎") ? "🅾️" : "❎"
    }
    
    func reset() {
        currentBoard = [String](repeating: "", count: 9)
        currentPlayer = "❎"
    }
}
