
import 'package:fondo_btg/domain/entities/fund.dart';

final mockFunds = [
  Fund(
    id: '1',
    name: 'FPV_BTG_PACTUAL_RECAUDADORA',
    minimumAmount: 75000,
    category: FundCategory.FPV,
  ),
  Fund(
    id: '2',
    name: 'FPV_BTG_PACTUAL_ECOPETROL',
    minimumAmount: 125000,
    category: FundCategory.FPV,
  ),
  Fund(
    id: '3',
    name: 'DEUDAPRIVADA',
    minimumAmount: 50000,
    category: FundCategory.FIC,
  ),
  Fund(
    id: '4',
    name: 'FDO-ACCIONES',
    minimumAmount: 250000,
    category: FundCategory.FIC,
  ),
  Fund(
    id: '5',
    name: 'FPV_BTG_PACTUAL_DINAMICA',
    minimumAmount: 100000,
    category: FundCategory.FPV,
  ),
];