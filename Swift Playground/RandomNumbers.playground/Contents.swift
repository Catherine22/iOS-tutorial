import UIKit


/*
 * Random numbers
 */
var loveScore = Int(arc4random_uniform(101)) // 0 ≤ loveScore ≤ 100
print(loveScore)
loveScore = Int.random(in: 0...100) // 0 ≤ loveScore ≤ 100
print(loveScore)
