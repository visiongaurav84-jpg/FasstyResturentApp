class RestaurantModel {
  final String image;
  final String title;
  final String subtitle;
  final String time;
  final String rating;

  RestaurantModel({
    required this.image,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.rating,
  });
}



List<RestaurantModel> restaurants = [
  RestaurantModel(
    image: "assets/images/11.png",
    title: "Diabetes",
    subtitle: "A chronic condition affecting how the body processes blood sugar.",
    time: "",
    rating: "4.2",
  ),
  RestaurantModel(
    image: "assets/images/22.jpg",
    title: "Hypertension",
    subtitle: "High blood pressure that increases risk of heart disease.",
    time: "",
    rating: "4.5",
  ),
  RestaurantModel(
    image: "assets/images/33.jpeg",
    title: "Asthma",
    subtitle: "A respiratory condition causing breathing difficulty and wheezing.",
    time: "",
    rating: "4.6",
  ),
  RestaurantModel(
    image: "assets/images/44.jpg",
    title: "Migraine",
    subtitle: "A neurological disorder causing severe headaches and nausea.",
    time: "",
    rating: "4.4",
  ),
];
