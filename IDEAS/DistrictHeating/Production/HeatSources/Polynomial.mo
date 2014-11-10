within IDEAS.DistrictHeating.Production.HeatSources;
model Polynomial "Heat source based on a polynomial function"
  //Extensions
  extends IDEAS.DistrictHeating.Production.BaseClasses.PartialHeatSource(
    QNomRef=data.QNomRef);

  //Parameters en Constants
  constant Real kgps2lph=3600/Medium.density(Medium.setState_pTX(Medium.p_default, Medium.T_default, Medium.X_default))*1000
    "Conversion from kg/s to l/h";
  parameter Real beta[10] "Constant parameters of the polynomial function";
  parameter Integer powers[10,4] "Constant powers of the polynomial function";

  //Variables
  Real modulationInit "Initial modulation, decides on start/stop of the HP";
  Real modulation(min=0, max=100) "Current modulation percentage";
  Real eta "Final efficiency of the heat source";
  Real release "Stop heat production when the mass flow is zero";

  Modelica.SIunits.Power QMax
    "Maximum thermal power at 100% modulation for the given input conditions";
  Modelica.SIunits.Power QAsked(start=0) "Desired power of the heatsource";
  Modelica.SIunits.Power QLossesToCompensate
    "Artificial heat losses to correct the heat balance";
  Modelica.SIunits.Power PFuel "Resulting fuel consumption";

  Real m_flowHx_scaled = IDEAS.Utilities.Math.Functions.smoothMax(x1=m_flow, x2=0,deltaX=0.001) * data.QNomRef/QNom
    "mass flow rate, scaled with the original and the actual nominal power of the boiler";

  //Components
  Modelica.Blocks.Logical.Hysteresis hysteresis(
    uLow=data.modulationMin,
    uHigh=data.modulationStart)
    annotation (Placement(transformation(extent={{-42,40},{-22,60}})));

  replaceable Data.Polynomials.Boiler data constrainedby
    BaseClasses.PartialData
    annotation (Placement(transformation(extent={{78,78},{98,98}})));
equation
  //Calculation of the modulation
  release = if noEvent(m_flow > Modelica.Constants.eps) then 1.0 else 0.0;
  hysteresis.u = modulationInit;
  modulationInit = QAsked/QMax*100;
  modulation = if noEvent(hysteresis.y) then min(modulationInit, 100) else 0;

  //Calcualation of the heat powers
  QMax = Poly2ndDegree3Inputs(beta=beta, powers=powers, X=100, Y=m_flowHx_scaled, Z=THxIn-273.15)/data.etaRef*QNom;
  QAsked = IDEAS.Utilities.Math.Functions.smoothMax(0, m_flow*(Medium.specificEnthalpy(Medium.setState_pTX(Medium.p_default, TSet, Medium.X_default)) -hIn), 10);
  QLossesToCompensate = if noEvent(modulation) > 0 then UALoss*(heatPort.T - sim.Te) else 0;

  //Polynomial
  eta = Poly2ndDegree3Inputs(beta=beta, powers=powers, X=modulation, Y=m_flowHx_scaled, Z=THxIn);
  heatPort.Q_flow = -eta/data.etaRef*modulation/100*QNom - QLossesToCompensate;
  PFuel = if release > 0.5 and noEvent(eta>Modelica.Constants.eps) then -heatPort.Q_flow/eta else 0;

end Polynomial;
