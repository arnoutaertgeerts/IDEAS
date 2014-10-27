within IDEAS.Fluid.FixedResistances.Examples;
model PlugFlowTemperaturePipe
  extends Modelica.Icons.Example;
  import IDEAS;

  IDEAS.Fluid.Movers.Pump pump(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=0.1)
    annotation (Placement(transformation(extent={{-62,30},{-42,50}})));
  IDEAS.Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=0.1)
    annotation (Placement(transformation(extent={{-32,30},{-12,50}})));
  IDEAS.Fluid.Sensors.TemperatureTwoPort senTem1(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=0.1)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-36})));
  IDEAS.Fluid.Sources.FixedBoundary bou(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,

    p=100000,
    T=373.15) annotation (Placement(transformation(extent={{-94,30},{-74,50}})));
  IDEAS.Fluid.Sources.FixedBoundary bou1(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,

    use_T=false,
    use_p=true,
    p=100000) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-70})));
  inner Modelica.Fluid.System system(p_ambient=101325)
                                   annotation (Placement(transformation(extent={{60,60},
            {80,80}},          rotation=0)));
  IDEAS.Fluid.FixedResistances.PlugFlowTemperaturePipe plugFlowTemperaturePipe(
    m_flow_nominal=0.1,
    D=0.2,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,

    L=100000) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,8})));
equation
  connect(pump.port_b, senTem.port_a) annotation (Line(
      points={{-42,40},{-32,40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pump.port_a, bou.ports[1]) annotation (Line(
      points={{-62,40},{-74,40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senTem1.port_b, bou1.ports[1]) annotation (Line(
      points={{-1.83187e-015,-46},{0,-46},{0,-60},{6.66134e-016,-60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senTem.port_b, plugFlowTemperaturePipe.port_a) annotation (Line(
      points={{-12,40},{0,40},{0,18}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senTem1.port_a, plugFlowTemperaturePipe.port_b) annotation (Line(
      points={{1.77636e-015,-26},{0,-26},{0,-2},{-1.83187e-015,-2}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (Diagram(graphics));
end PlugFlowTemperaturePipe;
