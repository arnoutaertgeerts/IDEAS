within IDEAS.DistrictHeating.Pipes;
model InsulatedPipeM "Insulated pipe model with /meter parameters"
  //Extensions
  extends IDEAS.Fluid.FixedResistances.Pipe_Insulated(
    redeclare package Medium = Medium,
    UA=G,
    m=V*Medium.Density,
    m_flow_nominal=m_flow_nominal,
    dp_nominal=dp_nominal);

  //Parameters
  parameter Modelica.SIunits.Length pipeLength;
  parameter Modelica.SIunits.Length pipeDiameter;
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal;
  parameter Modelica.SIunits.PressureDifference dp_nominal=0;

  parameter Modelica.SIunits.CoefficientOfHeatTransfer U
    "Heat transfer coefficient";
  final parameter Modelica.SIunits.ThermalConductance G=U*Modelica.Constants.pi*(pipeDiameter/2)^2
    "Thermal conductance";
  final parameter Modelica.SIunits.Volume V=pipeLength*Modelica.Constants.pi*(pipeDiameter/2)^2;
  parameter Boolean dynamicBalance = true
    "Set to true to use a dynamic balance, which often leads to smaller systems of equations"
    annotation (Evaluate=true, Dialog(tab="Dynamics", group="Equations"));

end InsulatedPipeM;
