enum FundCategory { FPV, FIC }

class Fund {
  final String id;
  final String name;
  final int minimumAmount;
  final FundCategory category;

  const Fund({
    required this.id,
    required this.name,
    required this.minimumAmount,
    required this.category,
  });

}