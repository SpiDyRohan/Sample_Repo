class StockList {
  int? key;
  String? symbol;
  String? company;
  String? industry;
  String? sectoralIndex;
  String? ltp;

  StockList(
      {this.key, this.symbol, this.company, this.industry, this.sectoralIndex, this.ltp});

  StockList.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    symbol = json['symbol'];
    company = json['company'];
    industry = json['industry'];
    sectoralIndex = json['sectoralIndex'];
    ltp = json['ltp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['symbol'] = this.symbol;
    data['company'] = this.company;
    data['industry'] = this.industry;
    data['sectoralIndex'] = this.sectoralIndex;
    data['ltp'] = this.ltp;
    return data;
  }
}