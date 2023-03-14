
import '../utils/images.dart';

List<ActiveBookingsModel> activeBooking = getActiveBooking();

class ActiveBookingsModel {
  int id;
  String serviceName;
  String serviceImage;
  String name;
  String date;
  String time;
  String status;
  int price;

  ActiveBookingsModel(this.id, this.serviceName, this.serviceImage, this.name,
      this.date, this.time, this.status, this.price);
}

List<ActiveBookingsModel> getActiveBooking() {
  List<ActiveBookingsModel> list = List.empty(growable: true);
  list.add(
    ActiveBookingsModel(0, "Full House Cleaning", home,
        "Jaylon Cleaning Services", "March 3,2023", "4pm", "In Process", 2599),
  );
  list.add(
    ActiveBookingsModel(1, "Kitchen Cleaning", home, "Sj Cleaning Services",
        "Jan 4,2023", "6am", "Assigned", 3000),
  );
  list.add(
    ActiveBookingsModel(3, "Kitchen Cleaning", home, "Kitchen Cleaner",
        "Fab 4,2023", "6pm", "Assigned", 3200),
  );
  list.add(
    ActiveBookingsModel(2, "Bedroom Cleaning", home, "John Cleaning Services",
        "Feb 17,2023", "6am", "Completed", 2499),
  );
  list.add(
    ActiveBookingsModel(5, "House Cleaning", home, "John Fuqua Cleaning Services",
        "Feb 28,2023", "8pm", "Completed", 2599),
  );
  list.add(
    ActiveBookingsModel(4, "Plumber", home,
        "Bathroom Plumber", "March 154,2023", "10am", "In Process", 2799),
  );

  list.add(
    ActiveBookingsModel(6, "Bedroom Cleaning", home, "John Cleaning Services",
        "Feb 17,2023", "7pm", "Cancel", 2499),
  );
  list.add(
    ActiveBookingsModel(7, "Bedroom Cleaning", home, "John Cleaning Services",
        "Feb 17,2023", "6pm", "Cancel", 2699),
  );


  return list;
}

void cancelBooking(int id) {
  activeBooking.removeAt(id);
}
