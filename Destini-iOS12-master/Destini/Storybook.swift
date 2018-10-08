//
//  Storybook.swift
//  Destini
//
//  Created by Catherine Chen on 08/10/2018.
//  Copyright © 2018 London App Brewery. All rights reserved.
//

import Foundation

class Storybook {
    var beginning: Story
    init () {
        // Our strings
        let story6 = "You bond with the murderer while crooning verses of \"Can you feel the love tonight\". He drops you off at the next town. Before you go he asks you if you know any good places to dump bodies. You reply: \"Try the pier.\""
        let storyPiece6 = Story(content: story6, futures: (answerA: nil, answerB: nil))
        
        let story5 = "As you smash through the guardrail and careen towards the jagged rocks below you reflect on the dubious wisdom of stabbing someone while they are driving a car you are in."
        let storyPiece5 = Story(content: story5, futures: (answerA: nil, answerB: nil))
        
        let story4 = "What? Such a cop out! Did you know traffic accidents are the second leading cause of accidental death for most adult age groups?"
        let storyPiece4 = Story(content: story4, futures: (answerA: nil, answerB: nil))
        
        let story3 = "As you begin to drive, the stranger starts talking about his relationship with his mother. He gets angrier and angrier by the minute. He asks you to open the glovebox. Inside you find a bloody knife, two severed fingers, and a cassette tape of Elton John. He reaches for the glove box."
        let section3a = Section("I love Elton John! Hand him the cassette tape.", storyPiece6)
        let section3b = Section("It\'s him or me! You take the knife and stab him.", storyPiece5)
        let storyPiece3 = Story(content: story3, futures: (answerA: section3a, answerB: section3b))
        
        let story2 = "He nods slowly, unphased by the question."
        let section2a = Section("At least he\'s honest. I\'ll climb in.", storyPiece3)
        let section2b = Section("Wait, I know how to change a tire.", storyPiece4)
        let storyPiece2 = Story(content: story2, futures: (answerA: section2a, answerB: section2b))
        
        let story1 = "Your car has blown a tire on a winding road in the middle of nowhere with no cell phone reception. You decide to hitchhike. A rusty pickup truck rumbles to a stop next to you. A man with a wide brimmed hat with soulless eyes opens the passenger door for you and asks: \"Need a ride, boy?\"."
        let section1a = Section("I\'ll hop in. Thanks for the help!", storyPiece3)
        let section1b = Section("Better ask him if he\'s a murderer first.", storyPiece2)
        let storyPiece1 = Story(content: story1, futures: (answerA: section1a, answerB: section1b))
        
        beginning = storyPiece1
    }
}
