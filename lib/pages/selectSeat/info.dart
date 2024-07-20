class TicketInfo {
  final int maLichChieu;
  final List<SeatInfo> danhSachVe;

  TicketInfo({required this.maLichChieu, required this.danhSachVe});

  Map<String, dynamic> toJson() {
    return {
      'maLichChieu': maLichChieu,
      'danhSachVe': danhSachVe.map((seat) => seat.toJson()).toList(),
    };
  }
}

class SeatInfo {
  final int maGhe;
  final int giaVe;

  SeatInfo({required this.maGhe, required this.giaVe});

  Map<String, dynamic> toJson() {
    return {
      'maGhe': maGhe,
      'giaVe': giaVe,
    };
  }
}
