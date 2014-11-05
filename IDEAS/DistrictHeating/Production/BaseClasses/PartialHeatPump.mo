within IDEAS.DistrictHeating.Production.BaseClasses;
record PartialHeatPump "Partial data record for heat pump data"
  extends Modelica.Icons.Record;
  extends PartialData;

  //Zeros in powerData and copData indicate that this data is not available or that the working point is outside of the working range of the device
  parameter Modelica.SIunits.Power[:,:] power "Power map for the heat pump";
  parameter Real[:,:] cop "Cop map for the heat pump";

end PartialHeatPump;
