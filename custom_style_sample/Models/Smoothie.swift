import Foundation

struct Smoothie: Equatable, Hashable, Codable, Identifiable {
  var id: String
  var title: String
  var description: String
  var price: Int
  var endDate: Date
}

fileprivate func date(year: Int, month: Int, day: Int) -> Date {
  let calendar = Calendar(identifier: .gregorian)
  return calendar.date(from: DateComponents(year: year, month: month, day: day))!
}

extension [Smoothie] {
  static let all = Smoothie.all
}

extension Smoothie {
  static let all: [Smoothie] = [
    .init(
      id: "berry-blue",
      title: "Berry Blue",
      description: "*Filling* and *refreshing*, this smoothie will fill you with joy!",
      price: 480,
      endDate: date(year: 2023, month: 2, day: 1)
    ),
    .init(
      id: "carrot-chops",
      title: "Carrot Chops",
      description: "*Packed* with vitamin A and C, Carrot Chops is a great way to start your day!",
      price: 500,
      endDate: date(year: 2023, month: 3, day: 1)
    ),
    .init(
      id: "pina-y-coco",
      title: "Piña y Coco",
      description: "Enjoy the *tropical* flavors of coconut and pineapple!",
      price: 430,
      endDate: date(year: 2023, month: 4, day: 1)
    ),
    .init(
      id: "hulking-lemonade",
      title: "Hulking Lemonade",
      description: "This is not just *any* lemonade. It will give you *powers* you'll struggle to control!",
      price: 450,
      endDate: date(year: 2023, month: 5, day: 1)
    ),
    .init(
      id: "kiwi-cutie",
      title: "Kiwi Cutie",
      description: "Kiwi Cutie is beautiful *inside* ***and*** *out*! Packed with nutrients to start your day!",
      price: 400,
      endDate: date(year: 2023, month: 6, day: 1)
    ),
    .init(
      id: "lemonberry",
      title: "Lemonberry",
      description: "A refreshing blend that's a *real kick*!",
      price: 500,
      endDate: date(year: 2023, month: 7, day: 1)
    ),
    .init(
      id: "love-you-berry-much",
      title: "Love You Berry Much",
      description: "If you *love* berries berry berry much, you will love this one!",
      price: 600,
      endDate: date(year: 2023, month: 8, day: 1)
    ),
    .init(
      id: "mango-jambo",
      title: "Mango Jambo",
      description: "Dance around with this *delicious* tropical blend!",
      price: 550,
      endDate: date(year: 2023, month: 9, day: 1)
    ),
    .init(
      id: "one-in-a-melon",
      title: "One in a Melon",
      description: "Feel special this summer with the *coolest* drink in our menu!",
      price: 500,
      endDate: date(year: 2023, month: 10, day: 1)
    ),
    .init(
      id: "papas-papaya",
      title: "Papa's Papaya",
      description: "Papa would be proud of you if he saw you drinking this!",
      price: 600,
      endDate: date(year: 2023, month: 11, day: 1)
    ),
    .init(
      id: "peanut-butter-cup",
      title: "Peanut Butter Cup",
      description: "Ever wondered what it was like to *drink a peanut butter cup*? Wonder no more!",
      price: 400,
      endDate: date(year: 2023, month: 12, day: 1)
    ),
    .init(
      id: "sailor-man",
      title: "That's a Smore!",
      description: "When the world seems to rock like you've had too much choc, that's *a smore*!",
      price: 500,
      endDate: date(year: 2023, month: 1, day: 1)
    ),
    .init(
      id: "thats-berry-bananas",
      title: "That's Berry Bananas!",
      description: "You'll go *crazy* with this classic!",
      price: 600,
      endDate: date(year: 2023, month: 2, day: 1)
    ),
    .init(
      id: "tropical-blue",
      title: "Tropical Blue",
      description: "A delicious blend of *tropical fruits and blueberries* will have you sambaing around like you never knew you could!",
      price: 600,
      endDate: date(year: 2023, month: 3, day: 1)
    ),
  ]
}
