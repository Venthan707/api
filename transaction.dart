 class transaction{
  String? userName,transactionModeName;
  int? createdBy,transactionModeId;

  transaction({this.transactionModeId,this.transactionModeName,this.createdBy,this.userName});
  factory transaction.formap(Map<String,dynamic> t){
    return transaction(
        transactionModeId :int.parse(t['transactionModeId'].toString()),
        transactionModeName : t['transactionModeName'].toString(),
      createdBy :int.parse(t['createdBy'].toString()),
      userName : t['userName'].toString(),

    );
  }
 }
