within IDEAS.DistrictHeating.Production.BaseClasses;
partial record PartialGenericModulatingData
  "Partial for a heat source data record which holds data of 6 modulation steps"
  extends Modelica.Icons.Record;

  final parameter Integer numberOfModulationSteps;
  parameter Real[numberOfModulationSteps] modVector
    "Modulation steps corresponding to the data in the modulation array";

  parameter Real[numberOfModulationSteps-1,:,:] modulations;

  final parameter Modelica.SIunits.Power QNom0
    "Nominal power of the boiler from which the power data are used in this model";
  constant Real etaNom
    "Nominal efficiency (higher heating value)of the xxx boiler at 50/30degC.  See datafile";
  parameter Real modulationMin(max=29) "Minimal modulation percentage";
  parameter Real modulationStart(min=min(30, modulationMin + 5))
    "Min estimated modulation level required for start of the heat source";
  parameter Modelica.SIunits.Temperature TMax "Maximum set point temperature";
  parameter Modelica.SIunits.Temperature TMin;

end PartialGenericModulatingData;
