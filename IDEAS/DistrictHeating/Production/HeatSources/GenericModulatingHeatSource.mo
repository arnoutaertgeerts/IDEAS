within IDEAS.DistrictHeating.Production.HeatSources;
model GenericModulatingHeatSource
  "A generic modulating heat source based on performance tables"
  import IDEAS;

  //Extensions
  extends IDEAS.DistrictHeating.Production.BaseClasses.PartialHeatSource;

  replaceable package Medium =
    Modelica.Media.Interfaces.PartialMedium;

  //Production Data
  replaceable
    IDEAS.DistrictHeating.Production.BaseClasses.PartialGenericModulatingData
    productionData constrainedby
    IDEAS.DistrictHeating.Production.BaseClasses.PartialGenericModulatingData
    annotation (Placement(transformation(extent={{-88,70},{-68,90}})),
      choicesAllMatching=true);

  //Parameters
  final parameter Integer numberOfModulationSteps "Number of modulation steps";
  final parameter Real[numberOfModulationSteps] modVector = productionData.modVector
    "Vector of the modulation steps, from low to high";

  final parameter Modelica.SIunits.Power QNom0 = productionData.QNom0
    "Nominal power of the boiler from which the power data are used in this model";
  constant Real etaNom = productionData.etaNom
    "Nominal efficiency (higher heating value)of the xxx boiler at 50/30degC.  See datafile";
  parameter Real modulationMin = productionData.modulationMin
    "Minimal modulation percentage";
  parameter Real modulationStart = productionData.modulationStart
    "Min estimated modulation level required for start of the heat source";
  parameter Modelica.SIunits.Temperature TMax=productionData.TMax
    "Maximum set point temperature";
  parameter Modelica.SIunits.Temperature TMin=productionData.TMin
    "Minimum set point temperature";

  //Variables
  Real[numberOfModulationSteps] etaVector
    "Thermal efficiency for the modulation steps";
  Real eta "Instantaneous efficiency of the boiler (higher heating value)";
  Real[numberOfModulationSteps] QVector
    "Thermal power for the 6 modulation steps";
  Modelica.SIunits.Power QMax
    "Maximum thermal power at specified evap and condr temperatures, in W";
  Modelica.SIunits.Power QAsked(start=0) "Output of the heatSource";
  Real modulationInit "Initial modulation, decides on start/stop of the boiler";
  Real modulation(min=0, max=1) "Current modulation percentage";
  Modelica.SIunits.Power PFuel "Resulting fuel consumption";

  //Components
  replaceable IDEAS.Controls.Control_fixme.Hyst_NoEvent_Var Control(
    use_input=false,
    enableRelease=true,
    uLow_val=modulationMin,
    uHigh_val=modulationStart,
    y(start=0),
    release(start=0)) "Standard control of the production unit"
    annotation (Placement(transformation(extent={{32,0},{52,20}})));

  Modelica.Blocks.Sources.RealExpression realExpression(y=modulationInit)
    annotation (Placement(transformation(extent={{-4,0},{16,20}})));

  Modelica.Blocks.Sources.RealExpression ThxIn[numberOfModulationSteps-1](y=THxIn
         - 273.15)
    annotation (Placement(transformation(extent={{-88,26},{-68,46}})));
  Modelica.Blocks.Sources.RealExpression mFlowHx[numberOfModulationSteps-1](
     y=m_flowHx_scaled*kgps2lph)
    annotation (Placement(transformation(extent={{-88,-26},{-68,-6}})));

  Modelica.Blocks.Tables.CombiTable2D[numberOfModulationSteps-1] modulationTables(
    each smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
    table={productionData.modulations[i,:,:] for i in 1:numberOfModulationSteps-1})
    "Array of tables with modulation data, from low to high"
    annotation (Placement(transformation(extent={{-42,0},{-22,20}})));

protected
  Real m_flowHx_scaled = IDEAS.Utilities.Math.Functions.smoothMax(x1=m_flowHx, x2=0,deltaX=0.001) * QNom0/QNom
    "mass flow rate, scaled with the original and the actual nominal power of the boiler";

  constant Real kgps2lph=3600/Medium.density(Medium.setState_pTX(Medium.p_default, Medium.T_default, Medium.X_default))*1000
    "Conversion from kg/s to l/h";

  Modelica.SIunits.HeatFlowRate QLossesToCompensate "Environment losses";
  Integer i "Integer to select data interval";

algorithm
  // all these are in kW
  etaVector[1]:=0;
  for i in 1:numberOfModulationSteps-1 loop
    etaVector[i+1]:=modulationTables[i].y;
  end for;

  QVector :=etaVector/etaNom .* modVector/100*QNom;
  // in W
  QMax :=QVector[numberOfModulationSteps];

  // Interpolation if  QVector[1]<QAsked<QVector[6], other wise extrapolation with slope = 0
  i := 1;
  for j in 1:numberOfModulationSteps-1 loop
    if QAsked > QVector[j] then
      i := j;
    end if;
  end for;

  modulationInit :=
    IDEAS.Utilities.Math.Functions.cubicHermiteLinearExtrapolation(
    x=QAsked,
    x1=QVector[i],
    x2=QVector[i + 1],
    y1=modVector[i],
    y2=modVector[i + 1],
    y1d=0,
    y2d=0);
  modulation :=Control.y*min(modulationInit, 100);
  eta :=IDEAS.Utilities.Math.Functions.cubicHermiteLinearExtrapolation(
    x=modulation,
    x1=modVector[i],
    x2=modVector[i + 1],
    y1=etaVector[i],
    y2=etaVector[i + 1],
    y1d=0,
    y2d=0);

  heatPort.Q_flow :=-
    IDEAS.Utilities.Math.Functions.cubicHermiteLinearExtrapolation(
    x=modulation,
    x1=modVector[i],
    x2=modVector[i + 1],
    y1=QVector[i],
    y2=QVector[i + 1],
    y1d=0,
    y2d=0) - Control.y*QLossesToCompensate;

equation
  assert(TSet < TMax and TSet > TMin, "The given set point temperature is not inside the covered range (20 -> 80 degC)");
  assert(m_flowHx_scaled*kgps2lph < 1300, "The given mass flow rate is outside the allowed range. Make sure that the mass flow
  is positive and not too high. The current mass flow equals " + String(m_flowHx) + " [kg/s] but its maximum value is for the chosen QNom is " + String(1300*QNom/QNom0/kgps2lph));

  Control.release = if noEvent(m_flowHx > Modelica.Constants.eps) then 1.0 else 0.0;

  QAsked = IDEAS.Utilities.Math.Functions.smoothMax(0, m_flowHx*(Medium.specificEnthalpy(Medium.setState_pTX(Medium.p_default,TSet, Medium.X_default)) -hIn), 10);

  // compensation of heat losses (only when the hp is operating)
  QLossesToCompensate = if noEvent(modulation > 0) then UALoss*(heatPort.T -
    TEnvironment) else 0;

  PFuel = if Control.release > 0.5 and noEvent(eta>Modelica.Constants.eps) then -heatPort.Q_flow/eta else 0;

  connect(ThxIn.y, modulationTables.u1) annotation (Line(
      points={{-67,36},{-54,36},{-54,16},{-44,16}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(mFlowHx.y, modulationTables.u2) annotation (Line(
      points={{-67,-16},{-54,-16},{-54,4},{-44,4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(realExpression.y, Control.u) annotation (Line(
      points={{17,10},{30,10}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(extent={{-100,-100},{100,100}},
          preserveAspectRatio=false), graphics),                         Icon(
        coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=false),
        graphics={Line(
          points={{0,100},{-80,-76}},
          color={255,0,0},
          smooth=Smooth.None)}));
end GenericModulatingHeatSource;
