within IDEAS.DistrictHeating.Pipes.Examples;
model PreinsulatedPipesExample

  //Extensions
  extends Modelica.Icons.Example;

  Modelica.Fluid.Sources.FixedBoundary returnsink(
    nPorts=1,
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    use_T=false,
    T=343.15)
    annotation (Placement(transformation(extent={{-94,38},{-74,58}})));

  Modelica.Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow=0.2,
    T=343.15,
    nPorts=1) annotation (Placement(transformation(extent={{-92,70},{-72,90}})));

  Modelica.Fluid.Sources.MassFlowSource_T boundary1(
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow=0.2,
    T=318.15,
    nPorts=1) annotation (Placement(transformation(extent={{92,38},{72,58}})));

  Modelica.Fluid.Sources.FixedBoundary supplysink(
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    use_T=false,
    T=343.15,
    nPorts=1) annotation (Placement(transformation(extent={{90,70},{70,90}})));

  Fluid.Sensors.TemperatureTwoPort TReturn(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=0.1)
    annotation (Placement(transformation(extent={{-40,38},{-60,58}})));
  Fluid.Sensors.TemperatureTwoPort TSupply(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=0.1)
    annotation (Placement(transformation(extent={{16,70},{36,90}})));
  PreinsulatedPipes preinsulatedPipe(
    redeclare package Medium1 =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    redeclare package Medium2 =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    m1_flow_nominal=0.1,
    m2_flow_nominal=0.1,
    L=100,
    rho=1000,
    lambdaG=1.5,
    lambdaI=0.0265,
    H=1.28,
    Do=0.1578,
    Di=0.0889,
    E=0.35)    annotation (Placement(transformation(extent={{-12,42},{8,66}})));
  Modelica.Blocks.Sources.Constant TGround(k=273 + 12)
    annotation (Placement(transformation(extent={{-68,4},{-48,24}})));
  Modelica.Fluid.Sources.FixedBoundary returnsink1(
    nPorts=1,
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    use_T=false,
    T=343.15)
    annotation (Placement(transformation(extent={{-92,-82},{-72,-62}})));
  Modelica.Fluid.Sources.MassFlowSource_T boundary2(
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow=0.2,
    T=343.15,
    nPorts=1) annotation (Placement(transformation(extent={{-90,-42},{-70,-22}})));
  Modelica.Fluid.Sources.MassFlowSource_T boundary3(
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow=0.2,
    T=318.15,
    nPorts=1) annotation (Placement(transformation(extent={{90,-82},{70,-62}})));
  Modelica.Fluid.Sources.FixedBoundary supplysink1(
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    use_T=false,
    T=343.15,
    nPorts=1) annotation (Placement(transformation(extent={{90,-22},{70,-2}})));
  Fluid.Sensors.TemperatureTwoPort TReturn1(
                                           redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=0.1)
    annotation (Placement(transformation(extent={{-46,-82},{-66,-62}})));
  Fluid.Sensors.TemperatureTwoPort TSupply1(
                                           redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=0.1)
    annotation (Placement(transformation(extent={{16,-22},{36,-2}})));
  TwinPipeGround TwinPipe(
    redeclare package Medium1 =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    m1_flow_nominal=0.1,
    m2_flow_nominal=0.1,
    L=100,
    rho=1000,
    lambdaG=1.5,
    lambdaI=0.0265,
    H=1.28,
    Do=0.1578,
    Di=0.0889,
    E=0.35,
    Dc=0.5,
    redeclare package Medium2 =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    annotation (Placement(transformation(extent={{-12,-50},{8,-26}})));
equation
  connect(returnsink.ports[1], TReturn.port_b) annotation (Line(
      points={{-74,48},{-60,48}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(TGround.y, preinsulatedPipe.Tg) annotation (Line(
      points={{-47,14},{-2,14},{-2,41.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TSupply.port_a, preinsulatedPipe.port_b1) annotation (Line(
      points={{16,80},{12,80},{12,60},{8,60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(returnsink1.ports[1], TReturn1.port_b) annotation (Line(
      points={{-72,-72},{-66,-72}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(TSupply1.port_a, TwinPipe.port_b1) annotation (Line(
      points={{16,-12},{12,-12},{12,-32},{8,-32}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(TReturn.port_a, preinsulatedPipe.port_b2) annotation (Line(
      points={{-40,48},{-12,48}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(preinsulatedPipe.port_a2, boundary1.ports[1]) annotation (Line(
      points={{8,48},{72,48}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(boundary.ports[1], preinsulatedPipe.port_a1) annotation (Line(
      points={{-72,80},{-28,80},{-28,60},{-12,60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(TSupply.port_b, supplysink.ports[1]) annotation (Line(
      points={{36,80},{70,80}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(TwinPipe.port_a1, boundary2.ports[1]) annotation (Line(
      points={{-12,-32},{-70,-32}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(TReturn1.port_a, TwinPipe.port_b2) annotation (Line(
      points={{-46,-72},{-22,-72},{-22,-44},{-12,-44}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(TwinPipe.port_a2, boundary3.ports[1]) annotation (Line(
      points={{8,-44},{28,-44},{28,-72},{70,-72}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(TSupply1.port_b, supplysink1.ports[1]) annotation (Line(
      points={{36,-12},{70,-12}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(TGround.y, TwinPipe.Tg) annotation (Line(
      points={{-47,14},{-34,14},{-34,-60},{-2,-60},{-2,-50.8}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end PreinsulatedPipesExample;
