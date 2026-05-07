import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/surah_model.dart';
import '../models/surah_detail_model.dart';

class SurahRepository {
  final String _baseUrl = 'https://equran.id/api/v2/surat';

  // Ambil daftar semua surah
  Future<List<SurahModel>> getDaftarSurah() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<dynamic> listSurah = data['data'];

        return listSurah.map((json) => SurahModel.fromJson(json)).toList();
      } else {
        throw Exception('Gagal memuat daftar surah');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }

  // Ambil detail surah berdasarkan nomor (termasuk daftar ayat)
  Future<SurahDetailModel> getDetailSurah(int nomor) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/$nomor'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        // Data detail berada di dalam field 'data'
        return SurahDetailModel.fromJson(data['data']);
      } else {
        throw Exception('Gagal memuat detail surah nomor $nomor');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan saat mengambil detail: $e');
    }
  }
}
