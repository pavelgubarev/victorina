import Foundation

public struct explanation {
    var shortText : String = ""
    var longTextFile : String = ""
    var link : URL!
}

extension explanation {
    init?(json: [String: Any]) {
        guard let shortDescription = json["Short Description"] as? String,
            let longDescription = json["Long Description"] as? String,
            let link = json["Link"] as?  String
            else {
                return nil
        }
        self.shortText = shortDescription
        self.longTextFile = longDescription
        self.link = URL(string: link)
    }
}

extension modelClass {
    func loadExplanations() {
        if let path = Bundle.main.path(forResource: "explanations", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                
                let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! [[String:Any]]
                
                for oneObj in json! {
                    if let oneExplanation = explanation(json: oneObj) {
                        explanations.append(oneExplanation)
                    }
                }
                
            } catch {
                print(error)
            }
        } else {
            print("Invalid filename/path.")
        }
    }
}
