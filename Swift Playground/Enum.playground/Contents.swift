import UIKit

var str = "Hello, playground"

/*
 * enum
 */
enum Poker: Int {
    case ace = 1
    case two, three, four, five, six, seven, eight, nine, ten
    case jack, queen, king
    
    func getDesc() -> String {
        switch self {
        case .ace:
            return "ace"
        case .jack:
            return "jack"
        case .queen:
            return "queen"
        case .king:
            return "king"
        default:
            return "\(self.rawValue)"
        }
    }
}

let act = Poker.ace
print(act.rawValue)
print(act.getDesc())

let eight = Poker.eight
print(eight.rawValue)
print(eight.getDesc())

enum Suit: String {
    case spade, diamond, heart, club
    func getSymbol() -> String {
        switch self {
        case .spade:
            return "♠︎"
        case .diamond:
            return "♦︎"
        case .heart:
            return "♥︎"
        case .club:
            return "♣︎"
        default:
            return "?"
        }
    }
}

let diamond = Suit.diamond
print(diamond.getSymbol())

enum Response {
    case success(Int, String)
    case failure(Int, String)
}

let albums = Response.success(200, "[{"title":"Taylor Swift","artist":"Taylor Swift","url":"https://www.amazon.com/Taylor-Swift/dp/B0014I4KH6","image":"https://images-na.ssl-images-amazon.com/images/I/61McsadO1OL.jpg","thumbnail_image":"https://i.imgur.com/K3KJ3w4h.jpg"}]")

let error = Response.failure(404, "Not Found")
