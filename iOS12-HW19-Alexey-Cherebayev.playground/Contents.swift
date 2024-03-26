import Foundation

func getData(urlRequest: String) {
    let urlRequest = URL(string: urlRequest)
    guard let url = urlRequest else { return }
    URLSession.shared.dataTask(with: url) { data, response, error in
        if error != nil {
            if let error = error {
                print("Error: \(error)")
            }
        } else if let response = response as? HTTPURLResponse {
            if response.statusCode > 200 {
                print("Response: \(response.statusCode) Ooops, something wrong. API Not Found")
            } else {
                guard let data = data else { return }
                let dataString = String(data: data, encoding: .utf8)
                if let data = dataString {
                    print("Status Code: \(response.statusCode)")
                    print("Data: \(data)")
                }
            }
        }
    }.resume()
}

getData(urlRequest: "https://cat-fact.herokuapp.com/facts")
