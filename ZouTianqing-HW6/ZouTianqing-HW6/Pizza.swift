// Project: ZouTianqing-HW5
// EID: tz4654
// Course: CS371L

class Pizza {

    var size: String
    var crust: String
    var cheese: String
    var meat: String
    var veggies: String
    // Firestore document id (used for swipe-to-delete).
    var documentID: String?

    init(size: String, crust: String, cheese: String, meat: String, veggies: String, documentID: String? = nil) {
        self.size = size
        self.crust = crust
        self.cheese = cheese
        self.meat = meat
        self.veggies = veggies
        self.documentID = documentID
    }

    func toFirestoreData() -> [String: Any] {
        [
            "size": size,
            "crust": crust,
            "cheese": cheese,
            "meat": meat,
            "veggies": veggies
        ]
    }
}
