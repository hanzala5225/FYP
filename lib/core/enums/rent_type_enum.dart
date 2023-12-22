enum RentTypeEnum{
  day('day'),
  week('week'),
  month('month');


  const RentTypeEnum(this.type);
  final String type;
}

// using an extension
extension ConvertRentTypeEnum on String{
  RentTypeEnum toRentTypeEnum(){
    switch(this){
      case 'day':
        return RentTypeEnum.day;
      case 'month':
        return RentTypeEnum.month;
      case 'week':
        return RentTypeEnum.week;
      default:
        return RentTypeEnum.day;
    }
  }
}