import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/claim_model.dart';

class ClaimsService {
  // Save a new claim
  Future<bool> saveClaim(ClaimModel claim) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final claimsJson = prefs.getString('claims') ?? '[]';
      final List<dynamic> claims = json.decode(claimsJson);
      claims.add(claim.toJson());
      await prefs.setString('claims', json.encode(claims));
      return true;
    } catch (e) {
      print('Error saving claim: $e');
      return false;
    }
  }

  // Get all claims for a user
  Future<List<ClaimModel>> getUserClaims(String userId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final claimsJson = prefs.getString('claims') ?? '[]';
      final List<dynamic> claims = json.decode(claimsJson);
      final userClaims = claims
          .where((claim) => claim['userId'] == userId)
          .map((claim) => ClaimModel.fromJson(claim))
          .toList();
      userClaims.sort((a, b) => b.date.compareTo(a.date));
      return userClaims;
    } catch (e) {
      print('Error getting claims: $e');
      return [];
    }
  }

  // Update an existing claim
  Future<bool> updateClaim(ClaimModel updatedClaim) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final claimsJson = prefs.getString('claims') ?? '[]';
      final List<dynamic> claims = json.decode(claimsJson);

      final index = claims.indexWhere((claim) => claim['id'] == updatedClaim.id);
      if (index != -1) {
        claims[index] = updatedClaim.toJson();
        await prefs.setString('claims', json.encode(claims));
        return true;
      }
      return false;
    } catch (e) {
      print('Error updating claim: $e');
      return false;
    }
  }

  // Delete a claim
  Future<bool> deleteClaim(String claimId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final claimsJson = prefs.getString('claims') ?? '[]';
      final List<dynamic> claims = json.decode(claimsJson);

      final index = claims.indexWhere((claim) => claim['id'] == claimId);
      if (index != -1) {
        claims.removeAt(index);
        await prefs.setString('claims', json.encode(claims));
        return true;
      }
      return false;
    } catch (e) {
      print('Error deleting claim: $e');
      return false;
    }
  }

  // Get claim statistics
  Future<Map<String, dynamic>> getClaimStats(String userId) async {
    final claims = await getUserClaims(userId);

    int total = claims.length;
    int approved = claims.where((c) => c.status == 'Approved').length;
    int pending = claims.where((c) => c.status == 'Pending').length;
    int processing = claims.where((c) => c.status == 'Processing').length;
    int rejected = claims.where((c) => c.status == 'Rejected').length;

    double totalAmount = claims
        .where((c) => c.status == 'Approved')
        .fold(0, (sum, claim) => sum + claim.amount);

    return {
      'total': total,
      'approved': approved,
      'pending': pending,
      'processing': processing,
      'rejected': rejected,
      'totalAmount': totalAmount,
    };
  }
}