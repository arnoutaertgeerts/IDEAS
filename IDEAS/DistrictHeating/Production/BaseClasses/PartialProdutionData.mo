within IDEAS.DistrictHeating.Production.BaseClasses;
partial record PartialProdutionData
  "Partial for a heat source data record which holds data of 6 modulation steps"
  extends Modelica.Icons.Record;

  Real[:,:] eta100;
  Real[:,:] eta80;
  Real[:,:] eta60;
  Real[:,:] eta40;
  Real[:,:] eta20;

end PartialProdutionData;
