import 'dart:convert';
import 'package:http/http.dart' as http;

//Auth token we will use to generate a meeting and connect to it
String token =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcGlrZXkiOiIyMzcxOGQ2Yy0yMTc2LTRmODMtYTUzMC1kNWU4OWIxM2UzOTIiLCJwZXJtaXNzaW9ucyI6WyJhbGxvd19qb2luIl0sImlhdCI6MTY4ODgyMjkyMiwiZXhwIjoxNjg5NDI3NzIyfQ.RkDkyK9eOb8-vjQkTzYx6zol2i5fj9ZUTowaFX-wvPQ";

// API call to create meeting
Future<String> createMeeting() async {
  final http.Response httpResponse = await http.post(
    Uri.parse("https://api.videosdk.live/v2/rooms"),
    headers: {'Authorization': token},
  );

//Destructuring the roomId from the response
  return json.decode(httpResponse.body)['roomId'];
}
