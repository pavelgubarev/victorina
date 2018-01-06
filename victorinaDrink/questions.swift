import Foundation

struct option {
    var text : String = ""
    var isCorrect : Bool = false
}

struct question {
    var text : String = ""
    var options = [option]()
}

extension question {
    init?(json: [String: Any]) {
        guard let text = json["text"] as? String,
        let optionsJSON = json["options"] as?  [[String: Any]]
            else {
                return nil
        }
        
        for optionJSON in optionsJSON {
            var newOption = option()
            newOption.text = optionJSON["text"] as! String
            newOption.isCorrect = optionJSON["isCorrect"] as! Bool
            self.options.append(newOption)
        }
        self.text = text
    }
}

extension engineClass {
    
    func loadQuestions() {
        if let path = Bundle.main.path(forResource: "questions", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                
                let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! [[String:Any]]
                
                for oneObj in json! {
                    if let oneQuestion = question(json: oneObj) {
                        questions.append(oneQuestion)
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
