//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Jasper Tan on 11/11/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var moveList = ["Rock", "Paper", "Scissors"]
    @State private var gameMoveIndex = Int.random(in: 0...2)
    
    
    // Game tracking
    @State private var gameWin: Bool = Bool.random()
    @State private var userScore: Int = 0
    @State private var currentRound: Int = 1
    @State private var afterRoundMessage: String = ""
    
    // Game configurations
    @State private var maxNumberOfRounds: Int = 5
    
    
    // Alerts
    @State private var userSelectedAlert: Bool = false
    @State private var gameOverAlert: Bool = false

    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 40) {
                    Text("Round \(currentRound) out of \(maxNumberOfRounds)")
                    
                    VStack {
                        Text("Game chose: \(moveList[gameMoveIndex])")
                        Text("Pick ___ to " + (gameWin ? "win" : "lose"))
                    }
                    
                    HStack(spacing: 30) {
                        ForEach(moveList, id: \.self) { move in
                            Button("\(move)") {
                                selectionCheck(move)
                            }
                        }
                    }
                    .alert(afterRoundMessage, isPresented: $userSelectedAlert)
                    {
                        Button("Next") {
                            if (currentRound >= maxNumberOfRounds) {
                                gameOverAlert = true
                            }
                            else {
                                nextRound()
                            }
                        }
                    } message: {
                        Text("Current Score: \(userScore)")
                    }
                    .alert("Game Over", isPresented: $gameOverAlert) {
                        Button("New Game") {
                            gameReset()
                        }
                    } message: {
                        Text("Final Score: \(userScore) out of \(maxNumberOfRounds)")
                    }


                }
                
            }
            .navigationTitle("Rock Paper Scissors!")
        }
    }
        
    func selectionCheck(_ move: String) {
        
        var wonRound: Bool = false
        
        if gameWin == true {
            if  (move == "Rock" && moveList[gameMoveIndex] == "Scissors") ||
                (move == "Paper" && moveList[gameMoveIndex] == "Rock") ||
                (move == "Scissors" && moveList[gameMoveIndex] == "Paper")
            {
                wonRound = true
            }
        }
        else { //gameWin == false
            if  (move == "Rock" && moveList[gameMoveIndex] == "Paper") ||
                (move == "Paper" && moveList[gameMoveIndex] == "Scissors") ||
                (move == "Scissors" && moveList[gameMoveIndex] == "Rock")
            {
                wonRound = true
            }
        }
        
        if (wonRound) {
            userScore += 1
            afterRoundMessage = "Correct!"
        }
        else {
            afterRoundMessage = "Wrong!"
        }
        
        userSelectedAlert = true
    }
    
    
    func nextRound() {
        currentRound += 1
        gameMoveIndex = Int.random(in: 0...2)
        gameWin = Bool.random()
    }
    
    func gameReset() {
        userScore = 0
        currentRound = 0
        nextRound()
    }
}

#Preview {
    ContentView()
}
