import SwiftUI

struct UserRequest: Codable {
    let nic: String?
    let email: String?
    let pass: String
    let metod: String
}

struct UserResponse: Codable {
    let status: String
    let message: String
}

struct NewsItem: Codable {
    let title: String
    let short_description: String
    let full_description: String
    let image_url: String
}

enum NetworkingError: Error {
    case invalidStatusCode(Int)
    case decodingFailed(Error)
    case requestFailed(Error)
    case noDataReceived
}

struct APIManager {
    func registerUser(nic: String, email: String, pass: String, completion: @escaping (Result<UserResponse, NetworkingError>) -> Void) {
        guard let url = URL(string: "https://gsforlife.homes/api.php") else {
            print("Error: Invalid URL")
            completion(.failure(.requestFailed(NSError(domain: "Invalid URL", code: 0))))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = UserRequest(nic: nic, email: email, pass: pass, metod: "registr")
        request.httpBody = try? JSONEncoder().encode(body)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailed(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.invalidStatusCode((response as? HTTPURLResponse)?.statusCode ?? 0)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noDataReceived))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(UserResponse.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(.decodingFailed(error)))
            }
        }
        task.resume()
    }
    
    func loginUser(email: String, pass: String, completion: @escaping (Result<UserResponse, NetworkingError>) -> Void) {
        guard let url = URL(string: "https://gsforlife.homes/api.php") else {
            print("Error: Invalid URL")
            completion(.failure(.requestFailed(NSError(domain: "Invalid URL", code: 0))))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = UserRequest(nic: nil, email: email, pass: pass, metod: "login")
        request.httpBody = try? JSONEncoder().encode(body)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailed(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.invalidStatusCode((response as? HTTPURLResponse)?.statusCode ?? 0)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noDataReceived))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(UserResponse.self, from: data)
                if result.status == "success" {
                    completion(.success(result))
                } else {
                    completion(.failure(.decodingFailed(NSError(domain: "InvalidResponse", code: 0))))
                }
            } catch {
                completion(.failure(.decodingFailed(error)))
            }
        }
        task.resume()
    }
    
    func getNews(email: String, pass: String, completion: @escaping (Result<[NewsItem], NetworkingError>) -> Void) {
        guard let url = URL(string: "https://gsforlife.homes/api.php") else {
            print("Error: Invalid URL")
            completion(.failure(.requestFailed(NSError(domain: "Invalid URL", code: 0))))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = UserRequest(nic: nil, email: email, pass: pass, metod: "news")
        request.httpBody = try? JSONEncoder().encode(body)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailed(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.invalidStatusCode((response as? HTTPURLResponse)?.statusCode ?? 0)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noDataReceived))
                return
            }
            
            do {
                let result = try JSONDecoder().decode([NewsItem].self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(.decodingFailed(error)))
            }
        }
        task.resume()
    }
    
    func getMatchForecast(email: String, pass: String, completion: @escaping (Result<[ForecastItem], NetworkingError>) -> Void) {
        guard let url = URL(string: "https://gsforlife.homes/api.php") else {
            print("Error: Invalid URL")
            completion(.failure(.requestFailed(NSError(domain: "Invalid URL", code: 0))))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = UserRequest(nic: nil, email: email, pass: pass, metod: "forecast")
        request.httpBody = try? JSONEncoder().encode(body)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailed(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.invalidStatusCode((response as? HTTPURLResponse)?.statusCode ?? 0)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noDataReceived))
                return
            }
            
            do {
                let result = try JSONDecoder().decode([ForecastItem].self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(.decodingFailed(error)))
            }
        }
        task.resume()
    }
    
    func deleteUser(email: String, pass: String, completion: @escaping (Result<UserResponse, NetworkingError>) -> Void) {
        guard let url = URL(string: "https://gsforlife.homes/api.php") else {
            completion(.failure(.requestFailed(NSError(domain: "Invalid URL", code: 0))))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = UserRequest(nic: nil, email: email, pass: pass, metod: "delete_user")
        request.httpBody = try? JSONEncoder().encode(body)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailed(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.invalidStatusCode((response as? HTTPURLResponse)?.statusCode ?? 0)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noDataReceived))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(UserResponse.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(.decodingFailed(error)))
            }
        }
        task.resume()
    }
}
