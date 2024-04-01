import Foundation
import CryptoKit

private func getData(urlRequest: String) {
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

func MD5(string: String) -> String {
    let digest = Insecure.MD5.hash(data: Data(string.utf8))

    return digest.map {
        String(format: "%02hhx", $0)
    }.joined()
}

// getData(urlRequest: "https://cat-fact.herokuapp.com/facts")

let publicKey = "2c364e5311aa169780edc7732e67b079"
let privateKey = "8461de92f59c753f5d5e17d897f4b1dc6a38c32f"
let hash = MD5(string: String(1) + privateKey + publicKey)
let apiUrl = "https://gateway.marvel.com/v1/public/comics/34?ts=1&apikey=\(publicKey)&hash=\(hash)"
getData(urlRequest: apiUrl)


