class Flashcard {
  final String question;
  final String answer;

  Flashcard({required this.question, required this.answer});
}

List<Flashcard> quesAnsList = [
  Flashcard(question: "Runway slope?", answer: "+/- 2%"),
  Flashcard(
      question: "Maximum Takeoff and Landing Tailwind Component?",
      answer: "15 knots"),
  Flashcard(
      question: "Maximum Operating Altitude?",
      answer: "43,100 feet pressure altitude"),
  Flashcard(
      question:
          "Maximum Takeoff and Landing Altitude (ET-ANN - ET-ANR, ET-AQL)?",
      answer: "8,400 feet pressure altitude"),
  Flashcard(
      question:
          "Maximum Takeoff and Landing Altitude (ET-APS - ET-APY, ET-ARH - ET-AWE)?",
      answer: "9,800 feet pressure altitude"),
  Flashcard(
      question:
          "The maximum field elevation is limited to(ET-APS - ET-APY, ET-ARH - ET-AWE)?",
      answer: "9,650 feet."),
  Flashcard(
      question: "The maximum demonstrated takeoff and landing crosswind is?",
      answer: "38 knots"),
  Flashcard(
      question: "Severe turbulent air penetration speed?",
      answer:
          "270 knots below 25,000 feet, 280 knots or 0.82 Mach whichever is lower at 25,000 feet and above. Maintain a minimum speed of 15 knots above the minimum maneuvering speed at all altitudes when airspeed is below 0.82 Mach."),
  Flashcard(
      question:
          "Prior to takeoff the maximum allowable difference between Captain’s or First Officer’s altitude display and field elevation is?",
      answer: "75 feet."),
  Flashcard(
      question:
          "Without LAND 2 or LAND 3 annunciated, the autopilot must be disengaged below",
      answer: "200 feet AGL"),
];
