import SwiftUI

struct NewsModel: Identifiable, Equatable {
    let id = UUID() 
    var name: String
    var desc: String
    var fullDesc: String
    var image: String
}

struct SportNewsModel {
    let arrayOfNewsModel = [NewsModel(name: "Stephen Curry's 3-point\nrecord",
                                      desc: "Steph Curry is on the verge of breaking Ray Allen's 3-point record",
                                      fullDesc: "Manchester United has officially announced the return of Cristiano Ronaldo to the club. The 39-year-old Portuguese star has signed a one-season contract and is ready to strengthen the team\'s attack in the upcoming campaign.",
                                      image: SportImageName.newsImage1.rawValue),
                            NewsModel(name: "Raiders fire head coach",
                                      desc: "The Las Vegas Raiders have fired head coach Jon Gruden after an internal investigation into emails he sent before being hired.",
                                      fullDesc: "Barcelona has announced the launch of their new kit for the 2025-2026 season, incorporating enhanced fabric technology for temperature regulation. The kit has been designed with player performance in mind to help achieve the best results on the field",
                                      image: SportImageName.newsImage2.rawValue),
                            NewsModel(name: "Simmons fined $360k for missing games",
                                      desc: "Ben Simmons has been fined $360,000 by the Philadelphia 76ers for missing games.",
                                      fullDesc: "French club Lyon is close to finalizing a deal with Karim Benzema. The Real Madrid striker has expressed interest in returning to his former club after his contract with Madrid expires at the end of the season.",
                                      image: SportImageName.newsImage3.rawValue),
                            NewsModel(name: "Lakers fire head coach",
                                      desc: "The Los Angeles Lakers have fired head coach Darvin Ham after a disappointing season and an early playoff exit.",
                                      fullDesc: "In a tense FA Cup final, Manchester City suffered a 2-1 defeat to Liverpool. Despite City\'s dominance for most of the match, Liverpool secured a last-minute winner to claim the trophy.",
                                      image: SportImageName.newsImage4.rawValue),
                            NewsModel(name: "Manchester City signs top midfielder",
                                      desc: "Manchester City has signed German midfielder Florian Wirtz from Bayer Leverkusen in a deal worth €90 million.",
                                      fullDesc: "Atletico Madrid has officially announced the signing of a young and talented goalkeeper to strengthen their squad ahead of the new season. The club believes he has the potential to become a future star.",
                                      image: SportImageName.newsImage5.rawValue)]
}


