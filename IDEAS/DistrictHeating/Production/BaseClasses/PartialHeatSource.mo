within IDEAS.DistrictHeating.Production.BaseClasses;
partial model PartialHeatSource
  "Partial for a heat source production component"

  replaceable package Medium =
      Modelica.Media.Interfaces.PartialMedium "Medium in the component";

  //Parameters
  parameter Modelica.SIunits.Power QNom "The power at nominal conditions";
  parameter Modelica.SIunits.ThermalConductance UALoss
    "UA of heat losses of the heat source to environment";

  //Inputs
  input Modelica.SIunits.Temperature THxIn "Condensor temperature";
  input Modelica.SIunits.Temperature TSet
    "Setpoint temperature for the fluid.  Not always possible to reach it";
  input Modelica.SIunits.MassFlowRate m_flowHx "Condensor mass flow rate";
  input Modelica.SIunits.Temperature TEnvironment
    "Temperature of environment for heat losses";
  input Modelica.SIunits.SpecificEnthalpy hIn "Specific enthalpy at the inlet";

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort
    "heatPort connection to water in condensor"
    annotation (Placement(transformation(extent={{90,-10},{110,10}}),
        iconTransformation(extent={{90,-10},{110,10}})));
  annotation (Icon(graphics={
                  Rectangle(
          extent={{-76,40},{44,-40}},
          lineColor={255,128,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),    Polygon(
          points={{-60,-30},{60,-30},{0,30},{-60,-30}},
          lineColor={255,128,0},
          smooth=Smooth.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          origin={74,0},
          rotation=270)}));
end PartialHeatSource;
