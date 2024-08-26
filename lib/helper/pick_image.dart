import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:convert';

class PickImages {
  Future<void> pickAndUploadImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      // Convert the selected image to a File
      File file = File(image.path);

      // Upload the image to Cloudinary
      String? cloudinaryUrl = await uploadImageToCloudinary(file);

      if (cloudinaryUrl != null) {
        print('Image uploaded successfully: $cloudinaryUrl');
        // Use the cloudinaryUrl as needed
      } else {
        print('Image upload failed');
      }
    }
  }

  Future<String?> uploadImageToCloudinary(File imageFile) async {
    String uploadUrl = "https://api.cloudinary.com/v1_1/di9vpom9l/image/upload";
    String apiKey = "521526247694514";
    String preset = "xyzabc"; // If using unsigned upload

    // Read the image file as bytes
    List<int> imageBytes = await imageFile.readAsBytes();
    String base64Image = base64Encode(imageBytes);

    // Prepare the request
    var request = http.MultipartRequest('POST', Uri.parse(uploadUrl));

    request.fields['file'] = base64Image;
    request.fields['upload_preset'] = preset;
    request.fields['api_key'] = apiKey;

    // Optionally add more parameters (e.g., tags)
    request.fields['tags'] = 'flutter_upload';

    // Send the request
    var response = await request.send();

    if (response.statusCode == 200) {
      // Parse the response
      var responseData = await http.Response.fromStream(response);
      var jsonResponse = jsonDecode(responseData.body);
      return jsonResponse['secure_url'];
    } else {
      print('Failed to upload image: ${response.statusCode}');
      return null;  // This is now allowed with the nullable return type
    }
  }

}
