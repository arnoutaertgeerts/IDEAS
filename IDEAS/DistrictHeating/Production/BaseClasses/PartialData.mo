within IDEAS.DistrictHeating.Production.BaseClasses;
partial record PartialData "Partial for every production data file"
  extends Modelica.Icons.Record;

  parameter Modelica.SIunits.Power QNomRef
    "Nominal power from which the power data are used in this model";

end PartialData;
