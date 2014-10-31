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
  annotation (Icon(coordinateSystem(extent={{-100,-100},{100,100}},
          preserveAspectRatio=false),
                   graphics={
        Rectangle(
          extent={{-80,76},{20,64}},
          lineColor={255,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={255,0,0}),
        Polygon(
          points={{0,100},{0,40},{40,70},{0,100}},
          lineColor={255,0,0},
          smooth=Smooth.None,
          fillPattern=FillPattern.Solid,
          fillColor={255,0,0}),
        Rectangle(
          extent={{-80,6},{20,-6}},
          lineColor={255,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={255,0,0}),
        Polygon(
          points={{0,30},{0,-30},{40,0},{0,30}},
          lineColor={255,0,0},
          smooth=Smooth.None,
          fillPattern=FillPattern.Solid,
          fillColor={255,0,0}),
        Rectangle(
          extent={{-80,-64},{20,-76}},
          lineColor={255,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={255,0,0}),
        Polygon(
          points={{0,-40},{0,-100},{40,-70},{0,-40}},
          lineColor={255,0,0},
          smooth=Smooth.None,
          fillPattern=FillPattern.Solid,
          fillColor={255,0,0})}), Diagram(coordinateSystem(extent={{-100,-100},
            {100,100}})));
end PartialHeatSource;
