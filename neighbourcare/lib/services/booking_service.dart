import 'package:file_picker/file_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BookingService {
  final _supabase = Supabase.instance.client;

  // 1. Pick and upload attachment (Web & Mobile safe using bytes)
  Future<String?> pickAndUploadAttachment() async {
    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
        withData: true,
      );

      if (result == null || result.files.single.bytes == null) {
        return null;
      }

      final fileBytes = result.files.single.bytes!;
      final fileName = '${DateTime.now().millisecondsSinceEpoch}_${result.files.single.name}';
      
      await _supabase.storage
          .from('booking_attachments')
          .uploadBinary(fileName, fileBytes);

      final publicUrl = _supabase.storage
          .from('booking_attachments')
          .getPublicUrl(fileName);

      return publicUrl;
    } catch (e) {
      print('Error uploading attachment: $e');
      return null;
    }
  }

  // 2. Create booking with the attachment URL and options
  Future<Map<String, dynamic>> createBookingWithAttachment({
    required String serviceType,
    required String location,
    required String notes,
    required String preferredTime,
    String? forumPostId,
    String? attachmentUrl,
  }) async {
    final userId = _supabase.auth.currentUser!.id;

    final response = await _supabase.from('bookings').insert({
      'client_id': userId,
      'provider_id': null,
      'service_type': serviceType,
      'forum_post_id': forumPostId,
      'status': 'pending',
      'total_amount': 0,
      'location': location,
      'notes': notes,
      'preferred_time': preferredTime,
      'attachment_url': attachmentUrl,
    }).select().single();

    return response;
  }

  // 3. Submit a provider quotation and remarks for a booking
  Future<void> submitQuotation({
    required String bookingId,
    required double quotedAmount,
    required String remarks,
  }) async {
    final user = _supabase.auth.currentUser;
    if (user == null) throw Exception('Not signed in');

    final provider = await _supabase
        .from('providers')
        .select('id')
        .eq('user_id', user.id)
        .single();

    final providerId = provider['id'];

    await _supabase.from('bookings').update({
      'provider_id': providerId,
      'total_amount': quotedAmount,
      'notes': remarks,
      'status': 'quoted',
    }).eq('id', bookingId);
  }

  // 4. Client accepts or rejects quotation / updates status
  Future<void> updateBookingStatus(String bookingId, String newStatus) async {
    await _supabase.from('bookings').update({
      'status': newStatus,
    }).eq('id', bookingId);
  }
}