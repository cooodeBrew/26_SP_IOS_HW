//
//  HW1solution.swift
//  ZouTianqing-HW10
//
// Project: ZouTianqing-HW10
// EID: tz4654
// Course: CS371L

import Foundation

// MARK: - Weapon

class Weapon {
    var weaponType: String
    var damage: Int

    init(weaponType: String) {
        self.weaponType = weaponType
        switch weaponType {
        case "dagger":  damage = 4
        case "axe":     damage = 6
        case "staff":   damage = 6
        case "sword":   damage = 10
        default:        damage = 1
        }
    }
}

// MARK: - Armor

class Armor {
    var armorType: String
    var armorClass: Int

    init(armorType: String) {
        self.armorType = armorType
        switch armorType {
        case "plate":   armorClass = 2
        case "chain":   armorClass = 6
        case "leather": armorClass = 8
        default:        armorClass = 10
        }
    }
}

// MARK: - RPGCharacter

class RPGCharacter {
    var name: String
    var maxHealth: Int
    var maxSpellPoints: Int
    var currentHealth: Int
    var currentSpellPoints: Int
    var weapon: Weapon
    var armor: Armor

    init(name: String, maxHealth: Int, maxSpellPoints: Int) {
        self.name = name
        self.maxHealth = maxHealth
        self.maxSpellPoints = maxSpellPoints
        currentHealth = maxHealth
        currentSpellPoints = maxSpellPoints
        weapon = Weapon(weaponType: "none")
        armor = Armor(armorType: "none")
    }

    func weaponAllowed(_ w: Weapon) -> Bool { return true }
    func armorAllowed(_ a: Armor) -> Bool { return true }

    func wield(weaponObject: Weapon) -> String {
        if weaponAllowed(weaponObject) {
            weapon = weaponObject
            return "\(name) is now wielding a(n) \(weaponObject.weaponType)"
        }
        return "Weapon not allowed for this character class."
    }

    func unwield() -> String {
        weapon = Weapon(weaponType: "none")
        return "\(name) is no longer wielding anything."
    }

    func putOnArmor(armorObject: Armor) -> String {
        if armorAllowed(armorObject) {
            armor = armorObject
            return "\(name) is now wearing \(armorObject.armorType)"
        }
        return "Armor not allowed for this character class."
    }

    func takeOffArmor() -> String {
        armor = Armor(armorType: "none")
        return "\(name) is no longer wearing any armor."
    }

    func fight(opponent: RPGCharacter) -> String {
        opponent.currentHealth -= weapon.damage
        var result = "\(name) attacks \(opponent.name) with a(n) \(weapon.weaponType)\n"
        result += "\(name) does \(weapon.damage) damage to \(opponent.name)\n"
        result += "\(opponent.name) is now down to \(opponent.currentHealth) health"
        let defeat = checkForDefeat(character: opponent)
        if !defeat.isEmpty { result += "\n" + defeat }
        return result
    }

    func show() -> String {
        return """
        \(name)
            Health:  \(currentHealth)
            Spell Points:  \(currentSpellPoints)
            Wielding:  \(weapon.weaponType)
            Wearing:  \(armor.armorType)
            AC:  \(armor.armorClass)
        """
    }

    func checkForDefeat(character: RPGCharacter) -> String {
        if character.currentHealth <= 0 {
            return "\(character.name) has been defeated!"
        }
        return ""
    }
}

// MARK: - Fighter

class Fighter: RPGCharacter {
    init(name: String) {
        super.init(name: name, maxHealth: 40, maxSpellPoints: 0)
    }
    // Fighters allow any weapon and any armor (defaults are already true)
}

// MARK: - Wizard

class Wizard: RPGCharacter {
    init(name: String) {
        super.init(name: name, maxHealth: 16, maxSpellPoints: 20)
    }

    override func weaponAllowed(_ w: Weapon) -> Bool {
        return w.weaponType == "dagger" || w.weaponType == "staff" || w.weaponType == "none"
    }

    override func armorAllowed(_ a: Armor) -> Bool {
        return a.armorType == "none"
    }

    func castSpell(spellName: String, target: RPGCharacter) -> String {
        var result = "\(name) casts \(spellName) at \(target.name)\n"

        let spellTable: [String: (cost: Int, effect: Int)] = [
            "Magic Missile": (1,  3),
            "Fireball":      (3,  5),
            "Lightning Bolt":(10, 10),
            "Heal":          (6, -6)
        ]

        guard let spell = spellTable[spellName] else {
            return result + "Unknown spell name. Spell failed."
        }

        guard currentSpellPoints >= spell.cost else {
            return result + "Insufficient spell points"
        }

        currentSpellPoints -= spell.cost

        if spell.effect < 0 {
            // Healing spell — cannot exceed target's max health
            let healAmt = min(-spell.effect, target.maxHealth - target.currentHealth)
            target.currentHealth += healAmt
            result += "\(name) heals \(target.name) for \(healAmt) health points\n"
            result += "\(target.name) is now at \(target.currentHealth) health"
        } else {
            target.currentHealth -= spell.effect
            result += "\(name) does \(spell.effect) damage to \(target.name)\n"
            result += "\(target.name) is now down to \(target.currentHealth) health"
            let defeat = checkForDefeat(character: target)
            if !defeat.isEmpty { result += "\n" + defeat }
        }

        return result
    }
}
