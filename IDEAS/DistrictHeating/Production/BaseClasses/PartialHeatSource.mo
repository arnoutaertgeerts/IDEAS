within IDEAS.DistrictHeating.Production.BaseClasses;
partial model PartialHeatSource
  "Partial for a heat source production component"

  replaceable package Medium =
      Modelica.Media.Interfaces.PartialMedium "Medium in the component";

  //Parameters
  parameter Real scaler = QNom/data.QNomRef;
  parameter Modelica.SIunits.Power QNom "The power at nominal conditions";
  parameter Modelica.SIunits.ThermalConductance UALoss
    "UA of heat losses of the heat source to environment";

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort
    "heatPort connection to water in condensor"
    annotation (Placement(transformation(extent={{90,-10},{110,10}}),
        iconTransformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.RealInput hIn "Specific enthalpy at the inlet" annotation (Placement(transformation(
          extent={{-128,60},{-88,100}}), iconTransformation(extent={{-120,48},{-96,
            72}})));
  Modelica.Blocks.Interfaces.RealInput m_flow "Condensor mass flow rate" annotation (Placement(transformation(
          extent={{-128,20},{-88,60}}), iconTransformation(extent={{-120,8},{-96,
            32}})));
  Modelica.Blocks.Interfaces.RealInput THxIn "Condensor temperature" annotation (Placement(transformation(
          extent={{-128,-60},{-88,-20}}), iconTransformation(extent={{-120,-32},
            {-96,-8}})));
  Modelica.Blocks.Interfaces.RealInput TSet
    "Setpoint temperature for the fluid.  Not always possible to reach it" annotation (Placement(transformation(
          extent={{-128,-94},{-88,-54}}), iconTransformation(extent={{-120,-72},
            {-94,-46}})));
  replaceable PartialData data
    annotation (Placement(transformation(extent={{78,78},{98,98}})));
    annotation (Placement(transformation(extent={{66,74},{86,94}})));
  outer SimInfoManager sim
    annotation (Placement(transformation(extent={{-38,78},{-18,98}})));
  annotation (Icon(coordinateSystem(extent={{-100,-100},{100,100}},
          preserveAspectRatio=false),
                   graphics={Rectangle(
          extent={{-100,80},{100,-80}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}), Line(
          points={{-60,60},{-38,60},{60,60},{40,40},{60,20},{40,0},{60,-20},{40,
              -40},{60,-60},{-60,-60}},
          color={255,0,0},
          smooth=Smooth.None),
        Rectangle(extent={{-100,80},{100,-80}}, lineColor={0,0,255})}),
                                 Diagram(coordinateSystem(extent={{-100,-100},{100,
            100}}, preserveAspectRatio=false), graphics));
end PartialHeatSource;
