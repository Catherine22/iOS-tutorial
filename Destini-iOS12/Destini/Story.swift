//
//  Story.swift
//  Destini
//
//  Created by Catherine Chen on 08/10/2018.
//  Copyright © 2018 London App Brewery. All rights reserved.
//

import Foundation

class Story {
    let content: String
    let futures: (answerA: Section?, answerB: Section?)
    
    init(content: String, futures: (answerA: Section?, answerB: Section?)) {
        self.content = content
        self.futures = futures
    }
}

class Section {
    let title: String
    let story: Story
    
    init (_ title: String, _ story: Story) {
        self.title = title
        self.story = story
    }
}
