import 'package:flutter/material.dart';
import '../models/reading_model.dart';

/// Repository berisi data bacaan-bacaan Islamic
class ReadingRepository {
  ReadingRepository._();

  /// Daftar semua bacaan utama
  static List<ReadingModel> getAllReadings() {
    return [
      _istighosahImage,
      _surahYasinImage,
      _doaSurahYasinImage,
      _doaSurahYasin2Image,
      _surahSurahImage,
      _manaqibCover,
      _manaqib1,
      _manaqib2,
      _manaqib3,
      _manaqib4,
      _manaqib5,
      _manaqib6,
      _manaqib7,
      _wahaisuntahaImage,
      _ibadallahImage,
      _yaArhamarRohiminImage,
      _nasyidLailahaIllallahImage,
      _nasyidSholatullahImage,
      _doaImage,
      _yaRabbiImage,
      _yaRasulImage,
      _alhamduMaulidImage,
      _fasubhanaImage,
      _ahdiruImage,
      _mahalulQiyamImage,
      _waWulidaImage,
      _wakanaImage,
      _doaMaulidImage,
      _fiHubbiImage,
      _doaAlfatihahImage,
      _nasyidTawasalnaImage,
      _nasyidAlMunajahImage,
      // _husainiyah,
      // _tahlil,
      // _maulidDiba,
      // _yasinFadilah,
    ];
  }

  /// Daftar semua doa
  static List<DoaModel> getAllDoa() {
    return [
      _doaSebelumTidur,
      _doaBangunTidur,
      _doaSebelumMakan,
      _doaSetelahMakan,
      _doaKeluarRumah,
      _doaMasukMasjid,
      _doaSetelahAdzan,
      _doaMohonIlmu,
      _doaKeduaOrangTua,
      _doaPenutupMajlis,
    ];
  }

  static ReadingModel getTahlil() => _tahlil;
  static ReadingModel getHusainiyah() => _husainiyah;
  static ReadingModel getYasinFadilah() => _yasinFadilah;

  // ═══════════════════════════════════════
  //  SURAT - SURAT
  // ═══════════════════════════════════════

  static const _suratYasin = ReadingModel(
    id: 'yasin',
    title: 'Surat Yasin',
    subtitle: 'Jantungnya Al-Quran • 83 Ayat',
    category: 'Surat',
    icon: Icons.menu_book_rounded,
    totalAyat: 83,
    arabicText: '''يس ﴿١﴾
وَٱلْقُرْءَانِ ٱلْحَكِيمِ ﴿٢﴾
إِنَّكَ لَمِنَ ٱلْمُرْسَلِينَ ﴿٣﴾
عَلَىٰ صِرَٰطٍ مُّسْتَقِيمٍ ﴿٤﴾
تَنزِيلَ ٱلْعَزِيزِ ٱلرَّحِيمِ ﴿٥﴾
لِتُنذِرَ قَوْمًا مَّآ أُنذِرَ ءَابَآؤُهُمْ فَهُمْ غَـٰفِلُونَ ﴿٦﴾
لَقَدْ حَقَّ ٱلْقَوْلُ عَلَىٰٓ أَكْثَرِهِمْ فَهُمْ لَا يُؤْمِنُونَ ﴿٧﴾
إِنَّا جَعَلْنَا فِىٓ أَعْنَـٰقِهِمْ أَغْلَـٰلًا فَهِىَ إِلَى ٱلْأَذْقَانِ فَهُم مُّقْمَحُونَ ﴿٨﴾
وَجَعَلْنَا مِنۢ بَيْنِ أَيْدِيهِمْ سَدًّا وَمِنْ خَلْفِهِمْ سَدًّا فَأَغْشَيْنَـٰهُمْ فَهُمْ لَا يُبْصِرُونَ ﴿٩﴾
وَسَوَآءٌ عَلَيْهِمْ ءَأَنذَرْتَهُمْ أَمْ لَمْ تُنذِرْهُمْ لَا يُؤْمِنُونَ ﴿١٠﴾''',
    latinText: '''Yaa siin (1)
Wal qur'aanil hakiim (2)
Innaka laminal mursaliin (3)
'Alaa siraatim mustaqiim (4)
Tanziilal 'aziizir rahiim (5)
Litundzira qauman maa undzira aabaaa'uhum fahum ghaafiluun (6)
Laqad haqqal qaulu 'alaa aktsarihim fahum laa yu'minuun (7)
Innaa ja'alnaa fii a'naaqihim aghlaalan fahiya ilal adzqaani fahum muqmahuun (8)
Wa ja'alnaa mim baini aidiihim saddaw wa min khalfihim saddan fa aghsyainaahum fahum laa yubsiruun (9)
Wa sawaa'un 'alaihim a andzartahum am lam tundzirhum laa yu'minuun (10)''',
    translationText: '''Yaa siin. (1)
Demi Al-Quran yang penuh hikmah, (2)
sungguh, engkau (Muhammad) adalah salah seorang dari rasul-rasul, (3)
(yang berada) di atas jalan yang lurus, (4)
(sebagai wahyu) yang diturunkan oleh (Allah) Yang Mahaperkasa, Maha Penyayang, (5)
agar engkau memberi peringatan kepada suatu kaum yang nenek moyangnya belum pernah diberi peringatan, karena itu mereka lalai. (6)
Sungguh, pasti berlaku perkataan (hukuman) terhadap kebanyakan mereka, karena mereka tidak beriman. (7)
Sungguh, Kami telah memasang belenggu di leher mereka, lalu tangan mereka (diangkat) ke dagu, karena itu mereka tertengadah. (8)
Dan Kami jadikan di hadapan mereka dinding dan di belakang mereka dinding (pula), dan Kami tutup (mata) mereka sehingga mereka tidak dapat melihat. (9)
Dan sama saja bagi mereka, apakah engkau memberi peringatan kepada mereka atau engkau tidak memberi peringatan kepada mereka, mereka tidak akan beriman. (10)''',
  );

  static const _suratAlMulk = ReadingModel(
    id: 'al-mulk',
    title: 'Surat Al-Mulk',
    subtitle: 'Kerajaan • 30 Ayat',
    category: 'Surat',
    icon: Icons.menu_book_rounded,
    totalAyat: 30,
    arabicText:
        '''تَبَـٰرَكَ ٱلَّذِى بِيَدِهِ ٱلْمُلْكُ وَهُوَ عَلَىٰ كُلِّ شَىْءٍ قَدِيرٌ ﴿١﴾
ٱلَّذِى خَلَقَ ٱلْمَوْتَ وَٱلْحَيَوٰةَ لِيَبْلُوَكُمْ أَيُّكُمْ أَحْسَنُ عَمَلًا وَهُوَ ٱلْعَزِيزُ ٱلْغَفُورُ ﴿٢﴾
ٱلَّذِى خَلَقَ سَبْعَ سَمَـٰوَٰتٍ طِبَاقًا مَّا تَرَىٰ فِى خَلْقِ ٱلرَّحْمَـٰنِ مِن تَفَـٰوُتٍ فَٱرْجِعِ ٱلْبَصَرَ هَلْ تَرَىٰ مِن فُطُورٍ ﴿٣﴾''',
    latinText:
        '''Tabaarakal ladzii biyadihil mulku wa huwa 'alaa kulli syai'in qadiir (1)
Alladzii khalaqal mauta wal hayaata liyabluwakum ayyukum ahsanu 'amalaa wa huwal 'aziizul ghafuur (2)
Alladzii khalaqa sab'a samaawaatin tibaaqaa maa taraa fii khalqir rahmaani min tafaawut farji'il basara hal taraa min futuur (3)''',
    translationText:
        '''Mahasuci Allah yang menguasai (segala) kerajaan, dan Dia Mahakuasa atas segala sesuatu, (1)
Yang menciptakan mati dan hidup, untuk menguji kamu, siapa di antara kamu yang lebih baik amalnya. Dan Dia Mahaperkasa, Maha Pengampun, (2)
Yang menciptakan tujuh langit berlapis-lapis. Tidak akan kamu lihat sesuatu yang tidak seimbang pada ciptaan Tuhan Yang Maha Pengasih. Maka lihatlah sekali lagi, adakah kamu lihat sesuatu yang cacat? (3)''',
  );

  static const _suratAlWaqiah = ReadingModel(
    id: 'al-waqiah',
    title: 'Surat Al-Waqi\'ah',
    subtitle: 'Hari Kiamat • 96 Ayat',
    category: 'Surat',
    icon: Icons.menu_book_rounded,
    totalAyat: 96,
    arabicText: '''إِذَا وَقَعَتِ ٱلْوَاقِعَةُ ﴿١﴾
لَيْسَ لِوَقْعَتِهَا كَاذِبَةٌ ﴿٢﴾
خَافِضَةٌ رَّافِعَةٌ ﴿٣﴾
إِذَا رُجَّتِ ٱلْأَرْضُ رَجًّا ﴿٤﴾
وَبُسَّتِ ٱلْجِبَالُ بَسًّا ﴿٥﴾''',
    latinText: '''Idzaa waqa'atil waaqi'ah (1)
Laisa liwaq'atihaa kaadzibah (2)
Khaafidatur raafi'ah (3)
Idzaa rujjatil ardu rajjaa (4)
Wa bussatil jibaalu bassaa (5)''',
    translationText: '''Apabila terjadi hari kiamat, (1)
tidak seorang pun dapat mendustakan terjadinya, (2)
(kejadian itu) merendahkan (satu golongan) dan meninggikan (golongan yang lain), (3)
apabila bumi diguncangkan sedahsyat-dahsyatnya, (4)
dan gunung-gunung dihancurkan sehancur-hancurnya, (5)''',
  );

  static const _suratArRahman = ReadingModel(
    id: 'ar-rahman',
    title: 'Surat Ar-Rahman',
    subtitle: 'Yang Maha Pemurah • 78 Ayat',
    category: 'Surat',
    icon: Icons.menu_book_rounded,
    totalAyat: 78,
    arabicText: '''ٱلرَّحْمَـٰنُ ﴿١﴾
عَلَّمَ ٱلْقُرْءَانَ ﴿٢﴾
خَلَقَ ٱلْإِنسَـٰنَ ﴿٣﴾
عَلَّمَهُ ٱلْبَيَانَ ﴿٤﴾
ٱلشَّمْسُ وَٱلْقَمَرُ بِحُسْبَانٍ ﴿٥﴾
وَٱلنَّجْمُ وَٱلشَّجَرُ يَسْجُدَانِ ﴿٦﴾''',
    latinText: '''Ar rahmaan (1)
'Allamal qur'aan (2)
Khalaqal insaan (3)
'Allamahul bayaan (4)
Asy syamsu wal qamaru bi husbaan (5)
Wan najmu wasy syajaru yasjudaan (6)''',
    translationText: '''(Allah) Yang Maha Pengasih, (1)
Yang telah mengajarkan Al-Quran, (2)
Dia menciptakan manusia, (3)
mengajarnya pandai berbicara. (4)
Matahari dan bulan (beredar) menurut perhitungan, (5)
dan tumbuhan dan pepohonan, keduanya tunduk (kepada-Nya). (6)''',
  );

  static const _ayatKursi = ReadingModel(
    id: 'ayat-kursi',
    title: 'Ayat Kursi',
    subtitle: 'Al-Baqarah: 255',
    category: 'Surat',
    icon: Icons.auto_stories_rounded,
    totalAyat: 1,
    arabicText:
        '''ٱللَّهُ لَآ إِلَـٰهَ إِلَّا هُوَ ٱلْحَىُّ ٱلْقَيُّومُ لَا تَأْخُذُهُۥ سِنَةٌ وَلَا نَوْمٌ لَّهُۥ مَا فِى ٱلسَّمَـٰوَٰتِ وَمَا فِى ٱلْأَرْضِ مَن ذَا ٱلَّذِى يَشْفَعُ عِندَهُۥٓ إِلَّا بِإِذْنِهِۦ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ وَلَا يُحِيطُونَ بِشَىْءٍ مِّنْ عِلْمِهِۦٓ إِلَّا بِمَا شَآءَ وَسِعَ كُرْسِيُّهُ ٱلسَّمَـٰوَٰتِ وَٱلْأَرْضَ وَلَا يَـُٔودُهُۥ حِفْظُهُمَا وَهُوَ ٱلْعَلِىُّ ٱلْعَظِيمُ''',
    latinText:
        '''Allaahu laa ilaaha illaa huwal hayyul qayyuum, laa ta'khudzuhuu sinatuw wa laa nauum, lahuu maa fis samaawaati wa maa fil ardh, man dzal ladzii yasyfa'u 'indahuu illaa bi idznihii, ya'lamu maa baina aidiihim wa maa khalfahum, wa laa yuhiithuuna bisyai'im min 'ilmihii illaa bimaa syaa'a, wasi'a kursiyyuhus samaawaati wal ardha, wa laa ya'uuduhuu hifzhuhumaa, wa huwal 'aliyyul 'azhiim.''',
    translationText:
        '''Allah, tidak ada tuhan selain Dia, Yang Mahahidup, Yang terus-menerus mengurus (makhluk-Nya), tidak mengantuk dan tidak tidur. Milik-Nya apa yang ada di langit dan apa yang ada di bumi. Tidak ada yang dapat memberi syafaat di sisi-Nya tanpa izin-Nya. Dia mengetahui apa yang di hadapan mereka dan apa yang di belakang mereka, dan mereka tidak mengetahui sesuatu apa pun tentang ilmu-Nya melainkan apa yang Dia kehendaki. Kursi-Nya meliputi langit dan bumi. Dan Dia tidak merasa berat memelihara keduanya, dan Dia Mahatinggi, Mahabesar.''',
  );

  static const _suratAlKahfi = ReadingModel(
    id: 'al-kahfi',
    title: 'Surat Al-Kahfi',
    subtitle: 'Penghuni Gua • 110 Ayat',
    category: 'Surat',
    icon: Icons.menu_book_rounded,
    totalAyat: 110,
    arabicText:
        '''ٱلْحَمْدُ لِلَّهِ ٱلَّذِىٓ أَنزَلَ عَلَىٰ عَبْدِهِ ٱلْكِتَـٰبَ وَلَمْ يَجْعَل لَّهُۥ عِوَجَا ﴿١﴾
قَيِّمًا لِّيُنذِرَ بَأْسًا شَدِيدًا مِّن لَّدُنْهُ وَيُبَشِّرَ ٱلْمُؤْمِنِينَ ٱلَّذِينَ يَعْمَلُونَ ٱلصَّـٰلِحَـٰتِ أَنَّ لَهُمْ أَجْرًا حَسَنًا ﴿٢﴾
مَّـٰكِثِينَ فِيهِ أَبَدًا ﴿٣﴾''',
    latinText:
        '''Alhamdu lillaahil ladzii anzala 'alaa 'abdihil kitaaba wa lam yaj'al lahuu 'iwajaa (1)
Qayyimal liyundzira ba'san syadiidam mil ladunhu wa yubasysyiral mu'miniinal ladziina ya'maluunas saalihaati anna lahum ajran hasanaa (2)
Maakitsiina fiihi abadaa (3)''',
    translationText:
        '''Segala puji bagi Allah yang telah menurunkan Kitab (Al-Quran) kepada hamba-Nya dan Dia tidak menjadikannya bengkok; (1)
sebagai bimbingan yang lurus, untuk memperingatkan akan siksa yang sangat pedih dari sisi-Nya dan memberikan kabar gembira kepada orang-orang mukmin yang mengerjakan kebajikan bahwa mereka akan mendapat balasan yang baik, (2)
mereka kekal di dalamnya untuk selama-lamanya, (3)''',
  );

  // ═══════════════════════════════════════
  //  DOA - DOA
  // ═══════════════════════════════════════

  static const _doaSebelumTidur = DoaModel(
    id: 'doa-sebelum-tidur',
    title: 'Doa Sebelum Tidur',
    arabicText: 'بِاسْمِكَ اللَّهُمَّ أَمُوتُ وَأَحْيَا',
    latinText: 'Bismikallaahumma amuutu wa ahyaa',
    translationText: 'Dengan nama-Mu ya Allah, aku mati dan aku hidup.',
    source: 'HR. Bukhari',
  );

  static const _doaBangunTidur = DoaModel(
    id: 'doa-bangun-tidur',
    title: 'Doa Bangun Tidur',
    arabicText:
        'اَلْحَمْدُ لِلَّهِ الَّذِيْ أَحْيَانَا بَعْدَ مَا أَمَاتَنَا وَإِلَيْهِ النُّشُوْرُ',
    latinText:
        'Alhamdulillaahil ladzii ahyaanaa ba\'da maa amaatanaa wa ilaihin nusyuur',
    translationText:
        'Segala puji bagi Allah yang telah menghidupkan kami sesudah mematikan kami, dan kepada-Nya kami akan dikembalikan.',
    source: 'HR. Bukhari',
  );

  static const _doaSebelumMakan = DoaModel(
    id: 'doa-sebelum-makan',
    title: 'Doa Sebelum Makan',
    arabicText:
        'اَللَّهُمَّ بَارِكْ لَنَا فِيْمَا رَزَقْتَنَا وَقِنَا عَذَابَ النَّارِ',
    latinText:
        'Allaahumma baarik lanaa fiimaa razaqtanaa wa qinaa \'adzaaban naar',
    translationText:
        'Ya Allah, berkahilah kami dalam rezeki yang telah Engkau berikan kepada kami dan peliharalah kami dari siksa api neraka.',
    source: 'HR. Ibnu Sunni',
  );

  static const _doaSetelahMakan = DoaModel(
    id: 'doa-setelah-makan',
    title: 'Doa Setelah Makan',
    arabicText:
        'اَلْحَمْدُ لِلَّهِ الَّذِيْ أَطْعَمَنَا وَسَقَانَا وَجَعَلَنَا مُسْلِمِيْنَ',
    latinText:
        'Alhamdulillaahil ladzii ath\'amanaa wa saqaanaa wa ja\'alanaa muslimiin',
    translationText:
        'Segala puji bagi Allah yang telah memberi makan kami dan memberi minum kami serta menjadikan kami sebagai orang-orang Islam.',
    source: 'HR. Abu Dawud',
  );

  static const _doaKeluarRumah = DoaModel(
    id: 'doa-keluar-rumah',
    title: 'Doa Keluar Rumah',
    arabicText:
        'بِسْمِ اللَّهِ تَوَكَّلْتُ عَلَى اللَّهِ وَلَا حَوْلَ وَلَا قُوَّةَ إِلَّا بِاللَّهِ',
    latinText:
        'Bismillaahi tawakkaltu \'alallaahi wa laa haula wa laa quwwata illaa billaah',
    translationText:
        'Dengan nama Allah, aku bertawakal kepada Allah, tidak ada daya dan kekuatan kecuali dengan pertolongan Allah.',
    source: 'HR. Abu Dawud & Tirmidzi',
  );

  static const _doaMasukMasjid = DoaModel(
    id: 'doa-masuk-masjid',
    title: 'Doa Masuk Masjid',
    arabicText: 'اَللَّهُمَّ افْتَحْ لِيْ أَبْوَابَ رَحْمَتِكَ',
    latinText: 'Allaahummaf tahlii abwaaba rahmatik',
    translationText: 'Ya Allah, bukakanlah untukku pintu-pintu rahmat-Mu.',
    source: 'HR. Muslim',
  );

  static const _doaSetelahAdzan = DoaModel(
    id: 'doa-setelah-adzan',
    title: 'Doa Setelah Adzan',
    arabicText:
        'اَللَّهُمَّ رَبَّ هَذِهِ الدَّعْوَةِ التَّامَّةِ وَالصَّلَاةِ الْقَائِمَةِ آتِ مُحَمَّدًا الْوَسِيْلَةَ وَالْفَضِيْلَةَ وَابْعَثْهُ مَقَامًا مَحْمُوْدًا الَّذِيْ وَعَدْتَهُ',
    latinText:
        'Allaahumma rabba haadzihid da\'watit taammah wash sholaatil qaa\'imah, aati Muhammadanil wasiilata wal fadhiilah, wab\'atshu maqaamam mahmuudanil ladzii wa\'adtah',
    translationText:
        'Ya Allah, Tuhan Pemilik seruan yang sempurna ini dan shalat yang akan didirikan, berikanlah kepada Muhammad wasilah dan keutamaan, dan bangkitkanlah beliau ke tempat yang terpuji yang telah Engkau janjikan kepadanya.',
    source: 'HR. Bukhari',
  );

  static const _doaMohonIlmu = DoaModel(
    id: 'doa-mohon-ilmu',
    title: 'Doa Mohon Ilmu',
    arabicText: 'رَبِّ زِدْنِيْ عِلْمًا وَارْزُقْنِيْ فَهْمًا',
    latinText: 'Rabbi zidnii \'ilman warzuqnii fahmaa',
    translationText:
        'Ya Tuhanku, tambahkanlah kepadaku ilmu dan berikanlah aku pemahaman.',
    source: 'QS. Thaha: 114',
  );

  static const _doaKeduaOrangTua = DoaModel(
    id: 'doa-kedua-orang-tua',
    title: 'Doa Untuk Kedua Orang Tua',
    arabicText: 'رَبِّ ارْحَمْهُمَا كَمَا رَبَّيَانِيْ صَغِيْرًا',
    latinText: 'Rabbirhamhumaa kamaa rabbayaanii shaghiiraa',
    translationText:
        'Ya Tuhanku, sayangilah keduanya sebagaimana mereka berdua telah mendidikku waktu kecil.',
    source: 'QS. Al-Isra: 24',
  );

  static const _doaPenutupMajlis = DoaModel(
    id: 'doa-penutup-majlis',
    title: 'Doa Penutup Majlis',
    arabicText:
        'سُبْحَانَكَ اللَّهُمَّ وَبِحَمْدِكَ أَشْهَدُ أَنْ لَا إِلَهَ إِلَّا أَنْتَ أَسْتَغْفِرُكَ وَأَتُوبُ إِلَيْكَ',
    latinText:
        'Subhaanakallaahumma wa bihamdika asyhadu an laa ilaaha illaa anta astaghfiruka wa atuubu ilaik',
    translationText:
        'Mahasuci Engkau ya Allah, dengan memuji-Mu aku bersaksi bahwa tiada tuhan selain Engkau, aku memohon ampun dan bertaubat kepada-Mu.',
    source: 'HR. Abu Dawud & Tirmidzi',
  );

  static const _bacaanImage = ReadingModel(
    id: 'bacaan-image',
    title: 'Bacaan Gambar',
    subtitle: 'Contoh bacaan menggunakan gambar panjang',
    category: 'E-Book',
    icon: Icons.image_rounded,
    arabicText: '',
    latinText: '',
    translationText: '',
    imageUrl: 'assets/images/content_11.jpg',
  );

  static const _manaqib1 = ReadingModel(
    id: 'manaqib-1',
    title: 'Manaqib Bab 1',
    subtitle: 'Kitab Manaqib Syekh Abdul Qodir Jaelani',
    category: 'Manaqib',
    icon: Icons.auto_stories_rounded,
    arabicText: '',
    latinText: '',
    translationText: '',
    imageUrl: 'assets/images/my_assets/manaqib_1.jpg',
  );

  static const _manaqib2 = ReadingModel(
    id: 'manaqib-2',
    title: 'Manaqib Bab 2',
    subtitle: 'Kitab Manaqib Syekh Abdul Qodir Jaelani',
    category: 'Manaqib',
    icon: Icons.auto_stories_rounded,
    arabicText: '',
    latinText: '',
    translationText: '',
    imageUrl: 'assets/images/my_assets/manaqib_2.jpg',
  );

  static const _manaqib3 = ReadingModel(
    id: 'manaqib-3',
    title: 'Manaqib Bab 3',
    subtitle: 'Kitab Manaqib Syekh Abdul Qodir Jaelani',
    category: 'Manaqib',
    icon: Icons.auto_stories_rounded,
    arabicText: '',
    latinText: '',
    translationText: '',
    imageUrl: 'assets/images/my_assets/manaqib_3.jpg',
  );

  static const _manaqib4 = ReadingModel(
    id: 'manaqib-4',
    title: 'Manaqib Bab 4',
    subtitle: 'Kitab Manaqib Syekh Abdul Qodir Jaelani',
    category: 'Manaqib',
    icon: Icons.auto_stories_rounded,
    arabicText: '',
    latinText: '',
    translationText: '',
    imageUrl: 'assets/images/my_assets/manaqib_4.jpg',
  );

  static const _manaqib5 = ReadingModel(
    id: 'manaqib-5',
    title: 'Manaqib Bab 5',
    subtitle: 'Kitab Manaqib Syekh Abdul Qodir Jaelani',
    category: 'Manaqib',
    icon: Icons.auto_stories_rounded,
    arabicText: '',
    latinText: '',
    translationText: '',
    imageUrl: 'assets/images/my_assets/manaqib_5.jpg',
  );

  static const _manaqib6 = ReadingModel(
    id: 'manaqib-6',
    title: 'Manaqib Bab 6',
    subtitle: 'Kitab Manaqib Syekh Abdul Qodir Jaelani',
    category: 'Manaqib',
    icon: Icons.auto_stories_rounded,
    arabicText: '',
    latinText: '',
    translationText: '',
    imageUrl: 'assets/images/my_assets/manaqib_6.jpg',
  );

  static const _manaqib7 = ReadingModel(
    id: 'manaqib-7',
    title: 'Manaqib Bab 7',
    subtitle: 'Kitab Manaqib Syekh Abdul Qodir Jaelani',
    category: 'Manaqib',
    icon: Icons.auto_stories_rounded,
    arabicText: '',
    latinText: '',
    translationText: '',
    imageUrl: 'assets/images/my_assets/manaqib_7.jpg',
  );

  static const _husainiyah = ReadingModel(
    id: 'husainiyah',
    title: 'Husainiyah',
    subtitle: 'Kumpulan Bacaan Husainiyah • 16 Halaman',
    category: 'E-Book',
    icon: Icons.collections_bookmark_rounded,
    arabicText: '',
    latinText: '',
    translationText: '',
    images: [
      'assets/images/my_assets/husainiyah/1619025281928.jpg',
      'assets/images/my_assets/husainiyah/1619025266214.jpg',
      'assets/images/my_assets/husainiyah/1619025254273.jpg',
      'assets/images/my_assets/husainiyah/1619025238904.jpg',
      'assets/images/my_assets/husainiyah/1619025226528.jpg',
      'assets/images/my_assets/husainiyah/1619025213041.jpg',
      'assets/images/my_assets/husainiyah/1619025201170.jpg',
      'assets/images/my_assets/husainiyah/1619025188433.jpg',
      'assets/images/my_assets/husainiyah/1619025173759.jpg',
      'assets/images/my_assets/husainiyah/1619025160671.jpg',
      'assets/images/my_assets/husainiyah/1619025147753.jpg',
      'assets/images/my_assets/husainiyah/1619025129523.jpg',
      'assets/images/my_assets/husainiyah/1619025109723.jpg',
      'assets/images/my_assets/husainiyah/1619025095163.jpg',
      'assets/images/my_assets/husainiyah/1619025082622.jpg',
      'assets/images/my_assets/husainiyah/1619025070095.jpg',
    ],
  );

  static const _maulidDiba = ReadingModel(
    id: 'maulid-diba',
    title: 'Maulid Diba',
    subtitle: 'Maulid ad-Diba\'i • 3 Halaman',
    category: 'Maulid',
    icon: Icons.menu_book_rounded,
    arabicText: '',
    latinText: '',
    translationText: '',
    images: [
      'assets/images/my_assets/maulid_diba/maulid_diba_1.jpg',
      'assets/images/my_assets/maulid_diba/maulid_diba_2.jpg',
      'assets/images/my_assets/maulid_diba/maulid_diba_3.jpg',
    ],
  );

  static const _tahlil = ReadingModel(
    id: 'tahlil',
    title: 'Tahlil & Doa',
    subtitle: 'Bacaan Tahlil Lengkap • 20 Halaman',
    category: 'Tahlil',
    icon: Icons.volunteer_activism_rounded,
    arabicText: '',
    latinText: '',
    translationText: '',
    images: [
      'assets/images/my_assets/tahlil/tahlil_1.jpg',
      'assets/images/my_assets/tahlil/tahlil_2.jpg',
      'assets/images/my_assets/tahlil/tahlil_3.jpg',
      'assets/images/my_assets/tahlil/tahlil_4.jpg',
      'assets/images/my_assets/tahlil/tahlil_5.jpg',
      'assets/images/my_assets/tahlil/tahlil_6.jpg',
      'assets/images/my_assets/tahlil/tahlil_7.jpg',
      'assets/images/my_assets/tahlil/tahlil_8.jpg',
      'assets/images/my_assets/tahlil/doa_tahlil_1.jpg',
      'assets/images/my_assets/tahlil/doa_tahlil_2.jpg',
      'assets/images/my_assets/tahlil/doa_tahlil_3.jpg',
      'assets/images/my_assets/tahlil/doa_tahlil_4.jpg',
      'assets/images/my_assets/tahlil/doa_tahlil_5.jpg',
      'assets/images/my_assets/tahlil/doa_tahlil_6.jpg',
      'assets/images/my_assets/tahlil/doa_tahlil_7.jpg',
      'assets/images/my_assets/tahlil/doa_tahlil_8.jpg',
      'assets/images/my_assets/tahlil/doa_tahlil_9.jpg',
      'assets/images/my_assets/tahlil/doa_tahlil_10.jpg',
      'assets/images/my_assets/tahlil/doa_tahlil_11.jpg',
      'assets/images/my_assets/tahlil/doa_tahlil_12.jpg',
    ],
  );

  static const _surahYasinImage = ReadingModel(
    id: 'yasin-image',
    title: 'Surat Yasin',
    subtitle: 'Bacaan Surat Yasin',
    category: 'E-Book',
    icon: Icons.image_rounded,
    arabicText: '',
    latinText: '',
    translationText: '',
    imageUrl: 'assets/images/my_assets/surah_yasin.jpg',
  );

  static const _istighosahImage = ReadingModel(
    id: 'istighosah-image',
    title: 'Istighosah',
    subtitle: 'Bacaan Istighosah',
    category: 'E-Book',
    icon: Icons.image_rounded,
    arabicText: '',
    latinText: '',
    translationText: '',
    imageUrl: 'assets/images/my_assets/istighosah.jpg',
  );

  static const _ahdiruImage = ReadingModel(
    id: 'ahdiru',
    title: 'Ahdiru Dan Fahtazal',
    subtitle: 'Bacaan Kitab',
    category: 'E-Book',
    icon: Icons.image_rounded,
    arabicText: '',
    latinText: '',
    translationText: '',
    imageUrl: 'assets/images/my_assets/ahdiruDanFahtazal.jpg',
  );

  static const _alhamduMaulidImage = ReadingModel(
    id: 'alhamdu-maulid',
    title: 'Alhamdu Maulid Diba',
    subtitle: 'Bacaan Kitab',
    category: 'Maulid',
    icon: Icons.image_rounded,
    arabicText: '',
    latinText: '',
    translationText: '',
    imageUrl: 'assets/images/my_assets/alhamdu_maulid_diba.jpg',
  );

  static const _doaImage = ReadingModel(
    id: 'doa-kitab',
    title: 'Doa',
    subtitle: 'Doa Manaqib',
    category: 'Doa',
    icon: Icons.image_rounded,
    arabicText: '',
    latinText: '',
    translationText: '',
    imageUrl: 'assets/images/my_assets/doa.jpg',
  );

  static const _doaAlfatihahImage = ReadingModel(
    id: 'doa-alfatihah',
    title: 'Doa Alfatihah',
    subtitle: 'Doa Khusus',
    category: 'Doa',
    icon: Icons.image_rounded,
    arabicText: '',
    latinText: '',
    translationText: '',
    imageUrl: 'assets/images/my_assets/doa_alfatihah.jpg',
  );

  static const _doaMaulidImage = ReadingModel(
    id: 'doa-maulid',
    title: 'Doa Maulid',
    subtitle: 'Doa Setelah Maulid',
    category: 'Maulid',
    icon: Icons.image_rounded,
    arabicText: '',
    latinText: '',
    translationText: '',
    imageUrl: 'assets/images/my_assets/doa_maulid.jpg',
  );

  static const _doaSurahYasinImage = ReadingModel(
    id: 'doa-yasin-1',
    title: 'Doa Surah Yasin',
    subtitle: 'Doa Setelah Yasin',
    category: 'Doa',
    icon: Icons.image_rounded,
    arabicText: '',
    latinText: '',
    translationText: '',
    imageUrl: 'assets/images/my_assets/doa_surah_yasin.jpg',
  );

  static const _doaSurahYasin2Image = ReadingModel(
    id: 'doa-yasin-2',
    title: 'Doa Surah Yasin 2',
    subtitle: 'Doa Setelah Yasin',
    category: 'Doa',
    icon: Icons.image_rounded,
    arabicText: '',
    latinText: '',
    translationText: '',
    imageUrl: 'assets/images/my_assets/doa_surah_yasin_2.jpg',
  );

  static const _fasubhanaImage = ReadingModel(
    id: 'fasubhana',
    title: 'Fasubhana Maulid Diba',
    subtitle: 'Bacaan Kitab',
    category: 'Maulid',
    icon: Icons.image_rounded,
    arabicText: '',
    latinText: '',
    translationText: '',
    imageUrl: 'assets/images/my_assets/fasubhana_maulid_diba.jpg',
  );

  static const _fiHubbiImage = ReadingModel(
    id: 'fi-hubbi',
    title: 'Fi Hubbi',
    subtitle: 'Bacaan Sholawat',
    category: 'E-Book',
    icon: Icons.image_rounded,
    arabicText: '',
    latinText: '',
    translationText: '',
    imageUrl: 'assets/images/my_assets/fi_hubbi.jpg',
  );

  static const _ibadallahImage = ReadingModel(
    id: 'ibadallah',
    title: 'Ibadallah Dan Doa Ibadallah',
    subtitle: 'Bacaan Kitab',
    category: 'E-Book',
    icon: Icons.image_rounded,
    arabicText: '',
    latinText: '',
    translationText: '',
    imageUrl: 'assets/images/my_assets/ibadallah_dan_doa_ibadallah.jpg',
  );

  static const _mahalulQiyamImage = ReadingModel(
    id: 'mahalul-qiyam',
    title: 'Mahalul Qiyam',
    subtitle: 'Bacaan Maulid',
    category: 'Maulid',
    icon: Icons.image_rounded,
    arabicText: '',
    latinText: '',
    translationText: '',
    imageUrl: 'assets/images/my_assets/mahalul_qiyam.jpg',
  );

  static const _nasyidAlMunajahImage = ReadingModel(
    id: 'nasyid-al-munajah',
    title: 'Nasyid Al Munajah',
    subtitle: 'Bacaan Nasyid',
    category: 'E-Book',
    icon: Icons.image_rounded,
    arabicText: '',
    latinText: '',
    translationText: '',
    imageUrl: 'assets/images/my_assets/nasyid_al_munajah.jpg',
  );

  static const _nasyidTawasalnaImage = ReadingModel(
    id: 'nasyid-tawasalna',
    title: 'Nasyid Tawasalna',
    subtitle: 'Bacaan Nasyid',
    category: 'E-Book',
    icon: Icons.image_rounded,
    arabicText: '',
    latinText: '',
    translationText: '',
    imageUrl: 'assets/images/my_assets/nasyid_tawasalna.jpg',
  );

  static const _surahSurahImage = ReadingModel(
    id: 'surah-surah',
    title: 'Surah Surah',
    subtitle: 'Kumpulan Surah Pendek',
    category: 'E-Book',
    icon: Icons.image_rounded,
    arabicText: '',
    latinText: '',
    translationText: '',
    imageUrl: 'assets/images/my_assets/surah_surah.jpg',
  );

  static const _wahaisuntahaImage = ReadingModel(
    id: 'wahaisuntaha',
    title: 'Wahaisuntaha',
    subtitle: 'Bacaan Kitab',
    category: 'E-Book',
    icon: Icons.image_rounded,
    arabicText: '',
    latinText: '',
    translationText: '',
    imageUrl: 'assets/images/my_assets/wahaisuntaha.jpg',
  );

  static const _wakanaImage = ReadingModel(
    id: 'wakana',
    title: 'Wakana',
    subtitle: 'Bacaan Kitab',
    category: 'E-Book',
    icon: Icons.image_rounded,
    arabicText: '',
    latinText: '',
    translationText: '',
    imageUrl: 'assets/images/my_assets/wakana.jpg',
  );

  static const _waWulidaImage = ReadingModel(
    id: 'wa-wulida',
    title: 'Wa Wulida',
    subtitle: 'Bacaan Kitab',
    category: 'E-Book',
    icon: Icons.image_rounded,
    arabicText: '',
    latinText: '',
    translationText: '',
    imageUrl: 'assets/images/my_assets/wa_wulida.jpg',
  );

  static const _yaArhamarRohiminImage = ReadingModel(
    id: 'ya-arhamar-rohimin',
    title: 'Ya Arhamar Rohimin',
    subtitle: 'Bacaan Sholawat',
    category: 'E-Book',
    icon: Icons.image_rounded,
    arabicText: '',
    latinText: '',
    translationText: '',
    imageUrl: 'assets/images/my_assets/ya_arhamar_rohimin.jpg',
  );

  static const _nasyidLailahaIllallahImage = ReadingModel(
    id: 'nasyid-lailaha-illallah',
    title: 'Nasyid Lailaha Illallah',
    subtitle: 'Bacaan Nasyid',
    category: 'E-Book',
    icon: Icons.image_rounded,
    arabicText: '',
    latinText: '',
    translationText: '',
    imageUrl: 'assets/images/my_assets/nasyid_lailaha_illallah.jpg',
  );

  static const _nasyidSholatullahImage = ReadingModel(
    id: 'nasyid-sholatullah',
    title: 'Nasyid Sholatullah',
    subtitle: 'Bacaan Nasyid',
    category: 'E-Book',
    icon: Icons.image_rounded,
    arabicText: '',
    latinText: '',
    translationText: '',
    imageUrl: 'assets/images/my_assets/nasyid_sholatullah.jpg',
  );

  static const _yaRabbiImage = ReadingModel(
    id: 'ya-rabbi',
    title: 'Ya Rabbi Maulid Diba',
    subtitle: 'Bacaan Maulid',
    category: 'Maulid',
    icon: Icons.image_rounded,
    arabicText: '',
    latinText: '',
    translationText: '',
    imageUrl: 'assets/images/my_assets/ya_rabbi_maulid_diba.jpg',
  );

  static const _yaRasulImage = ReadingModel(
    id: 'ya-rasul',
    title: 'Ya Rasul Maulid Diba',
    subtitle: 'Bacaan Maulid',
    category: 'Maulid',
    icon: Icons.image_rounded,
    arabicText: '',
    latinText: '',
    translationText: '',
    imageUrl: 'assets/images/my_assets/ya_rasul_maulid_diba.jpg',
  );

  static const _manaqibCover = ReadingModel(
    id: 'manaqib-cover',
    title: 'Manaqib',
    subtitle: 'Tawasul Manaqib',
    category: 'Manaqib',
    icon: Icons.auto_stories_rounded,
    arabicText: '',
    latinText: '',
    translationText: '',
    imageUrl: 'assets/images/my_assets/manaqib.jpg',
  );

  static const _yasinFadilah = ReadingModel(
    id: 'yasin-fadilah',
    title: 'Yasin Fadilah',
    subtitle: 'Surat Yasin Fadilah • 26 Halaman',
    category: 'Surat',
    icon: Icons.menu_book_rounded,
    arabicText: '',
    latinText: '',
    translationText: '',
    images: [
      'assets/images/my_assets/yasin_fadilah/yasin_fadilah_page-0001.jpg',
      'assets/images/my_assets/yasin_fadilah/yasin_fadilah_page-0002.jpg',
      'assets/images/my_assets/yasin_fadilah/yasin_fadilah_page-0003.jpg',
      'assets/images/my_assets/yasin_fadilah/yasin_fadilah_page-0004.jpg',
      'assets/images/my_assets/yasin_fadilah/yasin_fadilah_page-0005.jpg',
      'assets/images/my_assets/yasin_fadilah/yasin_fadilah_page-0006.jpg',
      'assets/images/my_assets/yasin_fadilah/yasin_fadilah_page-0007.jpg',
      'assets/images/my_assets/yasin_fadilah/yasin_fadilah_page-0008.jpg',
      'assets/images/my_assets/yasin_fadilah/yasin_fadilah_page-0009.jpg',
      'assets/images/my_assets/yasin_fadilah/yasin_fadilah_page-0010.jpg',
      'assets/images/my_assets/yasin_fadilah/yasin_fadilah_page-0011.jpg',
      'assets/images/my_assets/yasin_fadilah/yasin_fadilah_page-0012.jpg',
      'assets/images/my_assets/yasin_fadilah/yasin_fadilah_page-0013.jpg',
      'assets/images/my_assets/yasin_fadilah/yasin_fadilah_page-0014.jpg',
      'assets/images/my_assets/yasin_fadilah/yasin_fadilah_page-0015.jpg',
      'assets/images/my_assets/yasin_fadilah/yasin_fadilah_page-0016.jpg',
      'assets/images/my_assets/yasin_fadilah/yasin_fadilah_page-0017.jpg',
      'assets/images/my_assets/yasin_fadilah/yasin_fadilah_page-0018.jpg',
      'assets/images/my_assets/yasin_fadilah/yasin_fadilah_page-0019.jpg',
      'assets/images/my_assets/yasin_fadilah/yasin_fadilah_page-0020.jpg',
      'assets/images/my_assets/yasin_fadilah/yasin_fadilah_page-0021.jpg',
      'assets/images/my_assets/yasin_fadilah/yasin_fadilah_page-0022.jpg',
      'assets/images/my_assets/yasin_fadilah/yasin_fadilah_page-0023.jpg',
      'assets/images/my_assets/yasin_fadilah/yasin_fadilah_page-0024.jpg',
      'assets/images/my_assets/yasin_fadilah/yasin_fadilah_page-0025.jpg',
      'assets/images/my_assets/yasin_fadilah/yasin_fadilah_page-0026.jpg',
    ],
  );
}
