//
//  ContentView.swift
//  ZouTianqing-HW10
//
// Project: ZouTianqing-HW10
// EID: tz4654
// Course: CS371L

import SwiftUI

// MARK: - Global game objects (from HW1 main program)

let plateMail = Armor(armorType: "plate")
let chainMail = Armor(armorType: "chain")
let sword     = Weapon(weaponType: "sword")
let staff     = Weapon(weaponType: "staff")
let axe       = Weapon(weaponType: "axe")
let gandalf   = Wizard(name: "Gandalf the Grey")
let aragorn   = Fighter(name: "Aragorn")

// MARK: - ContentView

struct ContentView: View {
    @State private var isGandalfTurn  = true
    @State private var gandalfStatus  = gandalf.show()
    @State private var aragornStatus  = aragorn.show()
    @State private var messageText    = "Gandalf the Grey's turn"

    private var currentPlayer: RPGCharacter { isGandalfTurn ? gandalf : aragorn }
    private var opponent: RPGCharacter      { isGandalfTurn ? aragorn : gandalf }

    var body: some View {
        VStack(spacing: 0) {

            // Each column: status box on top, its buttons below
            HStack(alignment: .top, spacing: 8) {

                // Left column — Gandalf
                VStack(spacing: 40) {
                    statusBox(text: gandalfStatus, isActive: isGandalfTurn)

                    VStack(spacing: 14) {
                        Button("Fight") { fightAction() }

                        Menu {
                            Button("Staff") { wieldAction(weaponChoice: staff) }
                            Button("Axe")   { wieldAction(weaponChoice: axe) }
                            Button("Sword") { wieldAction(weaponChoice: sword) }
                        } label: {
                            Text("Wield")
                        }

                        Button("Unwield") { unwieldAction() }
                    }
                }

                // Right column — Aragorn
                VStack(spacing: 40) {
                    statusBox(text: aragornStatus, isActive: !isGandalfTurn)

                    VStack(spacing: 14) {
                        Menu {
                            Button("Fireball")       { castSpellAction(spellName: "Fireball") }
                            Button("Lightning Bolt") { castSpellAction(spellName: "Lightning Bolt") }
                            Button("Heal")           { castSpellAction(spellName: "Heal") }
                        } label: {
                            Text("Cast Spell")
                        }

                        Menu {
                            Button("Chain") { putOnAction(armorChoice: chainMail) }
                            Button("Plate") { putOnAction(armorChoice: plateMail) }
                        } label: {
                            Text("Put On")
                        }

                        Button("Take Off") { takeOffAction() }
                    }
                }
            }
            .frame(maxHeight: 440)
            .padding(.bottom, 40)

            // Message area
            ScrollView {
                Text(messageText)
                    .font(.system(size: 13))
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .padding(8)
            }
            .frame(maxWidth: .infinity, maxHeight: 110)
            .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.black, lineWidth: 1))

            Spacer()
        }
        .padding(.horizontal, 12)
        .padding(.bottom, 12)
        .padding(.top, 0)
    }

    private func statusBox(text: String, isActive: Bool) -> some View {
        ScrollView {
            Text(text)
                .font(.system(size: 13, design: .monospaced))
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .padding(6)
        }
        .frame(maxWidth: .infinity, minHeight: 200, maxHeight: .infinity)
        .overlay(RoundedRectangle(cornerRadius: 4).stroke(isActive ? Color.red : Color.black, lineWidth: 1))
    }


    private func updateStatus() {
        gandalfStatus = gandalf.show()
        aragornStatus = aragorn.show()
    }

    private func switchUser() -> String {
        isGandalfTurn.toggle()
        return "It is now \(currentPlayer.name)'s turn."
    }

    // MARK: - Button actions

    private func fightAction() {
        let msg = currentPlayer.fight(opponent: opponent)
        updateStatus()
        messageText = msg + "\n\n" + switchUser()
    }

    private func wieldAction(weaponChoice: Weapon) {
        let msg = currentPlayer.wield(weaponObject: weaponChoice)
        updateStatus()
        messageText = msg + "\n\n" + switchUser()
    }

    private func unwieldAction() {
        let msg = currentPlayer.unwield()
        updateStatus()
        messageText = msg + "\n\n" + switchUser()
    }

    private func castSpellAction(spellName: String) {
        guard let wizard = currentPlayer as? Wizard else {
            messageText = "Only wizards can cast spells.\n\n" + switchUser()
            return
        }
        let msg = wizard.castSpell(spellName: spellName, target: opponent)
        updateStatus()
        messageText = msg + "\n\n" + switchUser()
    }

    private func putOnAction(armorChoice: Armor) {
        let msg = currentPlayer.putOnArmor(armorObject: armorChoice)
        updateStatus()
        messageText = msg + "\n\n" + switchUser()
    }

    private func takeOffAction() {
        let msg = currentPlayer.takeOffArmor()
        updateStatus()
        messageText = msg + "\n\n" + switchUser()
    }
}

#Preview {
    ContentView()
}
