import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:aelius_customer/models/media_post_list.dart';
import 'package:aelius_customer/utils/shared_pref.dart';
import 'package:http/http.dart' as http;
import '../models/banner_list_model.dart';
import '../models/banner_model.dart';
import '../models/category.dart';
import '../models/user_model.dart';
import '../screens/dashboard_screen.dart';

String baseUrl = 'http://imusiccompany.com/api/';
String categoryUrl = '${baseUrl}categories';
String bannerUrl = '${baseUrl}banner';
String registerUrl = '${baseUrl}member/insert';
String loginUrl = '${baseUrl}login';
String updateProfilesUrl = '${baseUrl}customer/updateprofile';
String updateProfilImage = '${baseUrl}customer/updateprofile';
String bookingURL = '${baseUrl}booking';
String postUrl = '${baseUrl}media/post';
String likeUrl = '${baseUrl}media/like';
String findnearURL = '${baseUrl}member/find_near';
String favoriteURL = '${baseUrl}member/favourite';
String commentUrl = '${baseUrl}media/comment';
String mediaListUrl = '${baseUrl}media/medialist';

Future<Category> fetchCategories() async {
  final response = await http.get(Uri.parse(categoryUrl));
  var data = jsonDecode(response.body);
  if (response.statusCode == 200) {
    var jsons = Category.fromJson(data);
    print(jsons.data);
    return Category.fromJson(jsonDecode(response.body));
    // return Category(status: json.status, message:json.message, data:json.data);
  } else {
    throw Exception('Failed to load categories');
  }
}

Future<BannerModel> forntPageBanner() async {
  final responses = await http.post(Uri.parse(bannerUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, String>{'banner_for': 'customer'}));
  var data = jsonDecode(responses.body);
  if (responses.statusCode == 200) {
    var bannerModels = BannerModel.fromJson(data);
    print(bannerModels.data[0].image);
    print(responses.body);
    return BannerModel.fromJson(jsonDecode(responses.body));
  } else {
    throw Exception('Failed to load Banner');
  }
}

Future login(String mobileno) async {
  final responses = await http.post(Uri.parse(loginUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, String>{'mobile_number': mobileno}));
  var data = jsonDecode(responses.body);

  if (responses.statusCode == 200) {
    print(responses.body);
    print(data);
    String jsonString = jsonEncode(responses.body);

    SharedPref().setSharedPreferences(UserModel.fromJson(data));
    UserModel.fromJson(data);
    // return "success";
  } else {
    throw Exception('Failed to login user');
  }
}

Future<BannerListModel> fetchBannerList() async {
  final responses = await http.post(Uri.parse(bannerUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, String>{'banner_for': 'member'}));
  var data = jsonDecode(responses.body);
  if (responses.statusCode == 200) {
    var bannerModels = BannerListModel.fromJson(data);
    print(bannerModels.data[0].image);
    return BannerListModel.fromJson(jsonDecode(responses.body));
  } else {
    throw Exception('Failed to load Banner');
  }
}

Future registerUser(
  File image,
  String phonenumber,
  String companyName,
  String businesscategory,
  String region,
  String username,
  String email,
  String pincode,
  String refrecode,
) async {
  final url = Uri.parse(registerUrl);
  //
  final request = http.MultipartRequest('POST', url);

  request.fields['whatsapp_no'] = phonenumber;
  request.fields['company_name'] = companyName;
  request.fields['business_category'] = businesscategory;
  request.fields['region'] = region;
  request.fields['full_name'] = username;
  request.fields['email_id'] = email;
  request.fields['pincode'] = pincode;

  var pic = await http.MultipartFile.fromPath('image', image.path);

  request.files.add(pic);
  var response = await request.send();

  if (response.statusCode == 200) {
    print(response);
  } else {
    throw Exception('Failed to register user.');
  }
}

Future updateUser(
  String id,
  String username,
  String phonenumber,
  String email,
  String dateofBirth,
  String gender,
  String address,
  String region,
) async {
  final url = Uri.parse(updateProfilesUrl);
  //
  final request = http.MultipartRequest('POST', url);
  request.fields['id'] = id;
  request.fields['full_name'] = username;
  request.fields['whatsapp_no'] = phonenumber;
  request.fields['email_id'] = email;
  request.fields['date_of_birth'] = dateofBirth;
  request.fields['gender'] = gender;
  request.fields['regionresidence_adress'] = address;
  request.fields['region'] = region;
  var response = await request.send();
  if (response.statusCode == 200) {
    print(response);
  } else {
    throw Exception('Failed to register user.');
  }
}

Future scheduleBooking(String id, String categoryname, String startDate,
    String starttime, String description) async {
  final responses = await http.post(Uri.parse(bookingURL),
      body: jsonEncode(<String, String>{
        'customer_id': id,
        'category_name': categoryname,
        "start_date": startDate,
        "start_time": starttime,
        "description": description,
        "service_type": "schedule"
      }));
  var data = jsonDecode(responses.body);
  if (responses.statusCode == 200) {
    print(responses.body);
    return "success";
  } else {
    throw Exception('Failed to load Banner');
  }
}

Future immdiateBooking(
  String id,
  String categoryname,
  String address,
  String pincode,
) async {
  final responses = await http.post(Uri.parse(bookingURL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, String>{
        'customer_id': id,
        'category_name': categoryname,
        "address": address,
        "pincode": pincode,
        "service_type": "immediately"
      }));
  var data = jsonDecode(responses.body);
  if (responses.statusCode == 200) {
    print(responses.body);
    return "success";
  } else {
    throw Exception('Failed to load Banner');
  }
}

Future<MediaPostList> h2hMediaPostList() async {
  final responses = await http.post(
    Uri.parse(mediaListUrl),
  );
  var data = jsonDecode(responses.body);
  if (responses.statusCode == 200) {
    print(data);
    var mediapoStlist = MediaPostList.fromJson(data);
    print(mediapoStlist.data[0].image);

    return MediaPostList.fromJson(jsonDecode(responses.body));
  } else {
    throw Exception('Failed to load Banner');
  }
}

Future h2hMediaPost(
  String id,
  String desription,
  File image,
  String video,
) async {
  final responses = await http.post(Uri.parse(postUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, String>{
        'member_id': id,
        'desription': desription,
        "image": image.path,
        "video": video,
      }));
  var data = jsonDecode(responses.body);
  if (responses.statusCode == 200) {
    print(responses.body);
    return "success";
  } else {
    throw Exception('Failed to load Banner');
  }
}

Future h2hMediaLike(
  String customer_id,
  String member_id,
  String media_id,
) async {
  final responses = await http.post(Uri.parse(likeUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, String>{
        'media_id': media_id,
        'member_id': member_id,
        "customer_id": customer_id,
      }));
  var data = jsonDecode(responses.body);
  if (responses.statusCode == 200) {
    print(responses.body);
    return "success";
  } else {
    throw Exception('Failed to load Banner');
  }
}

Future favoriteServices(
  String customer_id,
  String member_id,
) async {
  final responses = await http.post(Uri.parse(favoriteURL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, String>{
        'member_id': member_id,
        "customer_id": customer_id,
      }));
  var data = jsonDecode(responses.body);
  if (responses.statusCode == 200) {
    print(responses.body);
    return "success";
  } else {
    throw Exception('Failed to load Banner');
  }
}

Future findnear(
  String category_id,
  String pincode,
  String region,
) async {
  final responses = await http.post(Uri.parse(findnearURL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, String>{
        'category_id': category_id,
        "pincode": pincode,
        'region': region,
      }));
  var data = jsonDecode(responses.body);
  if (responses.statusCode == 200) {
    print(responses.body);
    return "success";
  } else {
    throw Exception('Failed to load Banner');
  }
}

//
// Future rewardHistory(String referral_code  ) async {
//   final responses = await http.post(Uri.parse(schedulaebookingURL),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8'
//       },
//       body: jsonEncode(<String, String>{
//         'referral_code': referral_code,
//       }));
//   var data = jsonDecode(responses.body);
//   if (responses.statusCode == 200) {
//     print(responses.body);
//     return "success";
//   } else {
//     throw Exception('Failed to load Banner');
//   }
// }
