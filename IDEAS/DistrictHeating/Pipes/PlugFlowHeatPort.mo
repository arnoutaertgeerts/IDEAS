within IDEAS.DistrictHeating.Pipes;
model PlugFlowHeatPort
  "Pipe model with a temperature plug flow, pressure losses and heat exchange to the environment"

  //Extensions
  extends IDEAS.Fluid.Interfaces.PartialTwoPortInterface;
  final parameter Boolean from_dp=true "Used to satisfy replaceable models";

  //Parameters
  parameter Modelica.SIunits.Length pipeLength;
  parameter Modelica.SIunits.Length pipeDiameter;
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal;
  parameter Modelica.SIunits.PressureDifference dp_nominal;

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort
    "Port for heat exchange with mixing volume" annotation (Placement(
        transformation(extent={{-10,90},{10,110}}), iconTransformation(extent={{-10,90},
            {10,110}})));
  DistrictHeating.Pipes.PlugFlowPipe plugFlowPipe1
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Fluid.MixingVolumes.MixingVolume vol(
    redeclare package Medium = Medium,
    energyDynamics=if dynamicBalance then energyDynamics else Modelica.Fluid.Types.Dynamics.SteadyState,

    massDynamics=if dynamicBalance then massDynamics else Modelica.Fluid.Types.Dynamics.SteadyState,

    T_start=T_start,
    X_start=X_start,
    C_start=C_start,
    m_flow_nominal=m_flow_nominal,
    p_start=p_start,
    allowFlowReversal=allowFlowReversal,
    final V=m/Medium.density(Medium.setState_phX(
        Medium.p_default,
        Medium.h_default,
        Medium.X_default)),
    nPorts=2) annotation (Placement(transformation(extent={{52,0},{32,20}})));
  Fluid.MixingVolumes.MixingVolume vol1(
    redeclare package Medium = Medium,
    energyDynamics=if dynamicBalance then energyDynamics else Modelica.Fluid.Types.Dynamics.SteadyState,

    massDynamics=if dynamicBalance then massDynamics else Modelica.Fluid.Types.Dynamics.SteadyState,

    T_start=T_start,
    X_start=X_start,
    C_start=C_start,
    m_flow_nominal=m_flow_nominal,
    p_start=p_start,
    allowFlowReversal=allowFlowReversal,
    nPorts=2,
    final V=m/Medium.density(Medium.setState_phX(
        Medium.p_default,
        Medium.h_default,
        Medium.X_default)))
    annotation (Placement(transformation(extent={{-44,0},{-64,20}})));
equation
  connect(vol.heatPort, heatPort) annotation (Line(
      points={{52,10},{62,10},{62,54},{0,54},{0,100}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(port_a, vol1.ports[1]) annotation (Line(
      points={{-100,0},{-52,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(vol1.ports[2], plugFlowPipe1.port_a) annotation (Line(
      points={{-56,0},{-10,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(plugFlowPipe1.port_b, vol.ports[1]) annotation (Line(
      points={{10,0},{44,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(vol.ports[2], port_b) annotation (Line(
      points={{40,0},{100,0}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (Icon(graphics={
        Polygon(
          points={{20,-70},{60,-85},{20,-100},{20,-70}},
          lineColor={0,128,255},
          smooth=Smooth.None,
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          visible=showDesignFlowDirection),
        Polygon(
          points={{20,-75},{50,-85},{20,-95},{20,-75}},
          lineColor={255,255,255},
          smooth=Smooth.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          visible=allowFlowReversal),
        Polygon(
          points={{20,-75},{50,-85},{20,-95},{20,-75}},
          lineColor={255,255,255},
          smooth=Smooth.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          visible=allowFlowReversal),
        Rectangle(
          extent={{-100,42},{100,-40}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={192,192,192}),
        Rectangle(
          extent={{-100,24},{100,-22}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,127,255}),
        Rectangle(
          extent={{-26,24},{30,-22}},
          lineColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Line(
          points={{55,-85},{-60,-85}},
          color={0,128,255},
          smooth=Smooth.None,
          visible=showDesignFlowDirection),                                                                                                    Polygon(          points={{
              -10,-35},{-10,15},{0,35},{10,15},{10,-35},{-10,-35}},                                                                                                    lineColor={255,0,0},
            fillPattern =                                                                                                   FillPattern.Forward,          fillColor={255,255,255},
          origin={0,59},
          rotation=180)}), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics));
end PlugFlowHeatPort;
