import Foundation

struct explanation {
    var shortText : String = ""
    var link : URL!
}

extension explanation {
    init?(json: [String: Any]) {
        guard let shortDescription = json["Short Description"] as? String,
            let link = json["Link"] as?  String
            else {
                return nil
        }
        self.shortText = shortDescription
        self.link = URL(string: link)
    }
}
