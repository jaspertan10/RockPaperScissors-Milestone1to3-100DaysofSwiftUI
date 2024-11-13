//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Jasper Tan on 11/11/24.
//

import SwiftUI

extension Color {
    static let customSecondaryColor = Color(red: 0.71, green: 0.80, blue: 0.75)
    static let customPrimaryColor = Color(red: 0.996, green: 0.949, blue: 0.91)
    static let customAccentColor = Color(red: 0.992, green: 0.871, blue: 0.839)
    static let customAccentColor2 = Color(red: 0.945, green: 0.741, blue: 0.678)
}

struct ContentView: View {
    
    private let moveList = ["Rock", "Paper", "Scissors"]
    @State private var gameMoveIndex = Int.random(in: 0...2)
    private let moveListEmojiAttach = ["Rock" : "🪨", "Paper" : "📄", "Scissors" : "✂️"]
    
    
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
                
                Rectangle()
                    .fill(Color.customSecondaryColor.gradient)
                    .ignoresSafeArea()
//                Color.customSecondaryColor.gradient
//                    .ignoresSafeArea()
                
                VStack(spacing: 40) {
                    
                    Spacer()
                    
                    Text("Rock Paper Scissors")
                        .foregroundStyle(Color.customPrimaryColor)
                        .font(.largeTitle.weight(.heavy))
                        .shadow(radius: 5)
                    
                    Spacer()
                    
                    Text("Round \(currentRound) out of \(maxNumberOfRounds)")
                        .font(.callout)
                        .foregroundStyle(Color.customPrimaryColor)
                    
                    VStack {
                        Text("Game chose: \(moveListEmojiAttach[moveList[gameMoveIndex]] ?? moveList[gameMoveIndex])")
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(Color.customPrimaryColor)
                    }

                    
                    VStack {
                        Text("Pick to " + (gameWin ? "win" : "lose")) //todo: left off here, want to change it so the word 'lose' or 'win' is in a different color like customAccentColor2t.
                        
                        ForEach(moveList, id: \.self) { move in
//                            Button("\(move)") {
//                                selectionCheck(move)
//                            }
                            Button {
                                selectionCheck(move)
                            } label: {
                                //Text("\(move)")
                                if let emoji = moveListEmojiAttach[move] {
                                    ZStack {
                                        Circle()
                                            .fill(Color.customAccentColor)
                                            .padding()
                                            
                                        Text(emoji)
                                    }
                                } else {
                                    Text("\(move)")
                                }
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

                    Spacer()
                    
                    Text("Score: \(userScore)")
                        .font(.headline)
                }
                
            }
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
