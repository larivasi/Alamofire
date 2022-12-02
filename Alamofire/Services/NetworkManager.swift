//
//  NetworkManager.swift
//  Alamofire
//
//  Created by Vasyl Larin on 29.11.2022.
//

import Foundation
import Alamofire

enum Link: String {
    case coursesURL = "https://swiftbook.ru//wp-content/uploads/api/api_courses"
    case postRequest = "https://jsonplaceholder.typicode.com/posts"
    case courseImageURL = "https://swiftbook.ru/wp-content/uploads/sites/2/2018/08/notifications-course-with-background.png"
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchCourses(from url: String, completion: @escaping(Result<[Course], AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { [weak self] dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    let courses = Course.getCourses(from: value)
                    completion(.success(courses))
                    print(courses)
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func fetchData(from url: String, completion: @escaping(Result<Data, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseData { dataResponse in
                switch dataResponse.result {
                case .success(let imageData):
                    completion(.success(imageData))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func sendPostRequest(to url: String, with data: Course, completion: @escaping(Result<Course, AFError>) -> Void) {
        AF.request(url, method: .post, parameters: data)
            .validate()
            .responseDecodable(of: CourseJP.self) { dataResponse in
                switch dataResponse.result {
                case .success(let courseJP):
                    let course = Course(courseJP: courseJP)
                    completion(.success(course))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
