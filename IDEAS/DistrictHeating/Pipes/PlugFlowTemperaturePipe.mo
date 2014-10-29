within IDEAS.DistrictHeating.Pipes;
model PlugFlowTemperaturePipe
  extends Modelica.Icons.Example;
  import IDEAS;

  IDEAS.Fluid.Movers.Pump pump(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=1)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-60,60})));
  IDEAS.Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=0.1)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-60,24})));
  IDEAS.Fluid.Sensors.TemperatureTwoPort senTem1(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=0.1)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-60,-36})));
  IDEAS.Fluid.Sources.FixedBoundary bou(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    p=100000,
    T=373.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-60,86})));

  IDEAS.Fluid.Sources.FixedBoundary bou1(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    use_T=false,
    use_p=true,
    p=100000) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-60,-70})));

  inner Modelica.Fluid.System system(p_ambient=101325)
                                   annotation (Placement(transformation(extent={{60,60},
            {80,80}},          rotation=0)));
  IDEAS.DistrictHeating.Pipes.PlugFlowPipe plugFlowPipe(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,

    pipeDiameter=0.1,
    m_flow_nominal=0.1,
    res(redeclare package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater),
    plug(redeclare package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater),
    pipeLength=3.2,
    dp_nominal(displayUnit="Pa") = 20) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-60,-6})));

  IDEAS.Fluid.Movers.Pump pump1(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=1)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-20,60})));
  IDEAS.Fluid.Sensors.TemperatureTwoPort senTem2(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=0.1)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-20,24})));
  IDEAS.Fluid.Sensors.TemperatureTwoPort senTem3(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=0.1)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-20,-36})));
  IDEAS.Fluid.Sources.FixedBoundary bou2(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    p=100000,
    T=373.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-20,86})));

  IDEAS.Fluid.Sources.FixedBoundary bou3(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    use_T=false,
    use_p=true,
    p=100000) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-20,-70})));

  IDEAS.Fluid.FixedResistances.FixedResistanceDpM res(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal=0.1,
    dp_nominal=20) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-20,-6})));

equation
  connect(pump.port_b, senTem.port_a) annotation (Line(
      points={{-60,50},{-60,34}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pump.port_a, bou.ports[1]) annotation (Line(
      points={{-60,70},{-60,76}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senTem1.port_b, bou1.ports[1]) annotation (Line(
      points={{-60,-46},{-60,-60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senTem.port_b, plugFlowPipe.port_a) annotation (Line(
      points={{-60,14},{-60,4}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(plugFlowPipe.port_b, senTem1.port_a) annotation (Line(
      points={{-60,-16},{-60,-26}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pump1.port_b, senTem2.port_a) annotation (Line(
      points={{-20,50},{-20,34}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pump1.port_a, bou2.ports[1]) annotation (Line(
      points={{-20,70},{-20,76}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senTem3.port_b, bou3.ports[1]) annotation (Line(
      points={{-20,-46},{-20,-60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senTem2.port_b, res.port_a) annotation (Line(
      points={{-20,14},{-20,4}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senTem3.port_a, res.port_b) annotation (Line(
      points={{-20,-26},{-20,-16}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end PlugFlowTemperaturePipe;
