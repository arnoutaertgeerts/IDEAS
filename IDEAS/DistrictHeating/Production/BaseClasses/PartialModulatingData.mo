within IDEAS.DistrictHeating.Production.BaseClasses;
partial record PartialModulatingData
  "Partial for a heat source data record which holds data of 6 modulation steps"
  extends Modelica.Icons.Record;

  parameter Real[:,:] eta100;
  parameter Real[:,:] eta80;
  parameter Real[:,:] eta60;
  parameter Real[:,:] eta40;
  parameter Real[:,:] eta20;

  final parameter Modelica.SIunits.Power QNom0
    "Nominal power of the boiler from which the power data are used in this model";
  constant Real etaNom
    "Nominal efficiency (higher heating value)of the xxx boiler at 50/30degC.  See datafile";
  parameter Real modulationMin(max=29) "Minimal modulation percentage";
  parameter Real modulationStart(min=min(30, modulationMin + 5))
    "Min estimated modulation level required for start of the heat source";
  parameter Modelica.SIunits.Temperature TMax "Maximum set point temperature";
  parameter Modelica.SIunits.Temperature TMin;

end PartialModulatingData;
