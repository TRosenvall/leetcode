import UIKit

enum Need {
    case sleep
    case eat
    case drink
}

enum Want {
    case relax
    case work
    case makePurchase(item: Item)
}

enum Item {
    case bed
    case food
    case water
    case game
}

class StatBlock {
    var hp: Int
    var stamina: Int
    var tired: Int
    var hungry: Int
    var thirsty: Int
    var fun: Int
    var fulfillment: Int

    init(hp: Int, 
         stamina: Int,
         tired: Int,
         hungry: Int,
         thirsty: Int,
         fun: Int,
         fulfillment: Int
    ) {
        self.hp = hp
        self.stamina = stamina
        self.tired = tired
        self.hungry = hungry
        self.thirsty = thirsty
        self.fun = fun
        self.fulfillment = fulfillment
    }
}

class Entity {
    var name: String
    var stats: StatBlock
    let statModerationLevel: StatBlock
    var happiness: Int
    var inventory: [Item] = []

    init(name: String, 
         stats: StatBlock,
         statModerationLevel: StatBlock,
         happiness: Int
    ) {
        self.name = name
        self.stats = stats
        self.statModerationLevel = statModerationLevel
        self.happiness = happiness
    }
}

func update(need: Need) {
    
}

func update(want: Want) {
    
}


