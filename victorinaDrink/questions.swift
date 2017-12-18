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
