within IDEAS.DistrictHeating.Production.BaseClasses;
partial record PartialPerformanceMap
  extends Modelica.Icons.Record;
  extends PartialData;

  parameter IDEAS.Utilities.Tables.Space space(
    planes=performanceMap,
    n=numberOfModulations);

  parameter Integer numberOfModulations(min=2)
    "The number of modulation degrees";
  parameter IDEAS.Utilities.Tables.Plane[numberOfModulations] performanceMap
    "The performance map in the form of a space";
  parameter Real etaRef
    "Nominal efficiency (higher heating value)of the xxx boiler at 50/30degC.  See datafile";
  parameter Real modulationMin(max=29) "Minimal modulation percentage";
  parameter Real modulationStart(min=min(30, modulationMin + 5))
    "Min estimated modulation level required for start of the heat source";
  parameter Modelica.SIunits.Temperature TMax "Maximum set point temperature";
  parameter Modelica.SIunits.Temperature TMin "Minimum set point temperature";

end PartialPerformanceMap;
