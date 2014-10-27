within IDEAS.Fluid.FixedResistances;
model PlugFlowPipe
  "Pipe modelled using plug flow for the enthalpy and pressure losses"
  //Extensions
  extends IDEAS.Fluid.Interfaces.PartialTwoPortInterface;

  FixedResistanceDpM res
    annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
  FixedResistanceDpM res1
    annotation (Placement(transformation(extent={{60,30},{80,50}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b1(
                                redeclare package Medium = Medium,
                     m_flow(max=if allowFlowReversal then +Constants.inf else 0))
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-30,-10},{-50,10}},rotation=
             0), iconTransformation(extent={{110,-10},{90,10}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a1(
                                redeclare package Medium = Medium,
                     m_flow(min=if allowFlowReversal then -Constants.inf else 0))
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{30,-10},{50,10}},
            rotation=0)));
  MixingVolumes.MixingVolume             vol(
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
    final V=m/Medium.density(Medium.setState_phX(Medium.p_default, Medium.h_default, Medium.X_default)))
    annotation (Placement(transformation(extent={{10,0},{-10,20}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort
    "Port for heat exchange with mixing volume" annotation (Placement(
        transformation(extent={{-10,90},{10,110}}), iconTransformation(extent={{-10,90},
            {10,110}})));
equation
  connect(port_a1, port_a1) annotation (Line(
      points={{40,0},{40,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(port_a, res.port_a) annotation (Line(
      points={{-100,0},{-100,40},{-80,40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(res1.port_b, port_b) annotation (Line(
      points={{80,40},{100,40},{100,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(res.port_b, port_b1) annotation (Line(
      points={{-60,40},{-40,40},{-40,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(port_a1, res1.port_a) annotation (Line(
      points={{40,0},{40,40},{60,40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(port_b1, vol.ports[1]) annotation (Line(
      points={{-40,0},{2,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(vol.ports[2], port_a1) annotation (Line(
      points={{-2,0},{40,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(vol.heatPort, heatPort) annotation (Line(
      points={{10,10},{20,10},{20,60},{0,60},{0,100}},
      color={191,0,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end PlugFlowPipe;
