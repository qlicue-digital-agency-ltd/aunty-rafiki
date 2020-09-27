import 'package:flutter/material.dart';

import 'package:aunty_rafiki/models/tracker.dart';

class TrackerProvider extends ChangeNotifier {
  // tracker mock data
  List<Tracker> trackers = [
    Tracker(
      headText: "Your baby's growth: Conception to birth",
      subheadText: "Expert Advice",
      supportText:
          "You're pregnant. Congratulations! Are you curious how big your developing baby is, what your baby looks like as it grows inside you, and when you'll feel it move? Take a peek inside the womb to see how a baby develops from month to month.",
      media: "assets/baby/phototake_photo_of_8_week_fetus_circle.jpg",
      time: DateTime.parse("2020-01-01"),
    ),
    Tracker(
      headText: "Conception",
      subheadText: "Expert Advice",
      supportText:
          "Fertilization happens when a sperm meets and penetrates an egg. It's also called conception. At this moment, the genetic makeup is complete, including the sex of baby. Within about three days after conception, the fertilized egg is dividing very fast into many cells. It passes through the fallopian tube into the uterus, where it attaches to the uterine wall. The placenta, which will nourish the baby, also starts to form.",
      media: "assets/baby/getty_rm_photo_of_sperm_fertilizing_egg.jpg",
      time: DateTime.parse("2020-02-01"),
    ),
    Tracker(
      headText: "Development at 4 weeks",
      subheadText: "Expert Advice",
      supportText:
          "At this point the baby is developing the structures that will eventually form his face and neck. The heart and blood vessels continue to develop. And the lungs, stomach, the liver start to develop. A home pregnancy test would show positive",
      media: "assets/baby/getty_rm_photo_of_4_week_fetus.jpg",
      time: DateTime.parse("2020-03-01"),
    ),
    Tracker(
      headText: "Development at 8 weeks",
      subheadText: "Expert Advice",
      supportText:
          "The baby is now a little over half an inch in size. Eyelids and ears are forming, and you can see the tip of the nose. The arms and legs are well formed. The fingers and toes grow longer and more distinct.",
      media: "assets/baby/phototake_photo_of_8_week_fetus.jpg",
      time: DateTime.parse("2020-04-01"),
    ),
    Tracker(
      headText: "Development at 12 weeks",
      subheadText: "Expert Advice",
      supportText:
          "The baby measures about 2 inches and starts to make its own movements. you may start to feel the top of your uterus above your pubic bone. Your doctor may hear the baby's heartbeat with special instruments. The sex organs of the baby should start to become clear.",
      media: "assets/baby/phototake_photo_of_12_week_fetus.jpg",
      time: DateTime.parse("2020-05-01"),
    ),
    Tracker(
      headText: "Development at 16 weeks",
      subheadText: "Expert Advice",
      supportText:
          "The baby now measures about 4.3 to 4.6 inches and weighs about 3.5 ounces. You should be able to feel the top of your uterus about 3 inches below your belly button. The baby's eyes can blink and the heart and blood vessels are fully formed. The baby's fingers and toes have fingerprints.",
      media: "assets/baby/PRinc_photo_of_fetus_at_16_weeks.jpg",
      time: DateTime.parse("2020-06-01"),
    ),
    Tracker(
      headText: "Development at 20 weeks",
      subheadText: "Expert Advice",
      supportText:
          "The baby weighs about 10 ounces and is a little more than 6 inches long. Your uterus should be at the level of your belly button. The baby can suck a thumb, yawn, stretch, and make faces. Soon -- if you haven't already -- you'll feel your baby move, which is called 'quickening'.",
      media: "assets/baby/nilsson_rm_photo_of_20_week_fetus.jpg",
      time: DateTime.parse("2020-07-01"),
    ),
    Tracker(
      headText: "Time for an Ultrasound",
      subheadText: "Expert Advice",
      supportText:
          "An ultrasound is usually done for all pregnant women at 20 weeks. During this ultrasound, the doctor will make sure that the placenta is healthy and attached normally and that your baby is growing properly. You can see the baby's heartbeat and movement of its body, arms and legs on the ultrasound. You can usually find out whether it's a boy or a girl at 20 weeks.",
      media: "assets/baby/comp_rm_photo_ultrasound_20_weeks.jpg",
      time: DateTime.parse("2020-08-01"),
    ),
    Tracker(
      headText: "Development at 24 weeks",
      subheadText: "Expert Advice",
      supportText:
          "The baby weighs about 1.4 pounds now and responds to sounds by moving or incresing his pulse. You may notice jerking motions if his hiccups. With the inner ear fully developed, the baby may be able to sense being upside down in the womb.",
      media: "assets/baby/phototake_photo_ultrasound_24_weeks.jpg",
      time: DateTime.parse("2020-09-01"),
    ),
    Tracker(
      headText: "Development at 28 weeks",
      subheadText: "Expert Advice",
      supportText:
          "The baby weighs about 2 pounds, 6 ounces, and changes position often at this point in pregnancy. If you had to deliver prematurely now, there is good chance the baby would survive. Ask your doctor about preterm labor warning signs. Now is the time to register for birthing classes. Birthing classes prepare you for many aspects of childbirth, including labor and delivery and taking care of your newborn.",
      media: "assets/baby/nilsson_rm_photo_28_weeks.jpg",
      time: DateTime.parse("2020-10-01"),
    ),
    Tracker(
      headText: "Development at 32 weeks",
      subheadText: "Expert Advice",
      supportText:
          "The baby weighs almost 4 pounds and is moving around often. The baby's skin has fewer wrinkles as a layer of fat starts to form under the skin. Between now and delivery, your baby will gain up to half his birth weight. Ask your doctor how to do a fetal movement chart. Think about breastfeeding. You may notice a yellowish fluid leaking from your breasts. That is colostrum, and it happens to get your breasts ready for making milk. Most women go to the doctor every two weeks at this stage of pregnancy.",
      media: "assets/baby/istock_photo_of_pregnancy.jpg",
      time: DateTime.parse("2020-11-01"),
    ),
    Tracker(
      headText: "Developement at 36 weeks",
      subheadText: "Expert Advice",
      supportText:
          "Babies differ in size, depending on many factors, such as gender, the number of babies being carried, and size of the parents. So your baby's overall rate of growth is as important as the actual size. On average, a baby at this stage is about 18.5 inches and weighs close to 6 pounds. The brain has been developing repidly. Lungs are nearly full developed. The head is usually positioned down into the pelvis by now. Your baby is considered at 'term' when he is 37 weeks. He is an early term baby if born between 37-39 weeks, at term, if he's 39-40 weeks and late term if he's 41-42 weeks.",
      media: "assets/baby/nilsson_rm_photo_36_week_fetus.jpg",
      time: DateTime.parse("2020-12-01"),
    ),
    Tracker(
      headText: "Birth",
      subheadText: "Expert Advice",
      supportText:
          "A mother's due date marks the end of her 40th week. The delivery date is calculated using the first day of her last period. Based on this, pregnancy can last between 38 and 42 weeks with a full-term delivery happening around 40 weeks. Some post-term pregnancies -- those lasting more than 42 weeks -- are not really late. The due date may just not be accurate. For safety reasons, most babies are delivered by 42 weeks. Sometimes the doctor may need to induce labor.",
      media: "assets/baby/phototake_newborn_at_birth.jpg",
      time: DateTime.parse("2021-01-01"),
    ),
  ];
}
