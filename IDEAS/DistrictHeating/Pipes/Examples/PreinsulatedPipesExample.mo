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
  Modelica.Blocks.Sources.Constant TGround(k=273 + 12)
    annotation (Placement(transformation(extent={{-70,0},{-50,20}})));
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
  DoublePipes.TwinPipeGround twinPipeGround
    annotation (Placement(transformation(extent={{-12,-52},{8,-24}})));
  DoublePipes.PreinsulatedPipes preinsulatedPipes
    annotation (Placement(transformation(extent={{-16,46},{4,74}})));
equation
  connect(returnsink.ports[1], TReturn.port_b) annotation (Line(
      points={{-74,48},{-60,48}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(returnsink1.ports[1], TReturn1.port_b) annotation (Line(
      points={{-72,-72},{-66,-72}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(TSupply.port_b, supplysink.ports[1]) annotation (Line(
      points={{36,80},{70,80}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(TSupply1.port_b, supplysink1.ports[1]) annotation (Line(
      points={{36,-12},{70,-12}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(boundary2.ports[1], twinPipeGround.port_a1) annotation (Line(
      points={{-70,-32},{-12,-32}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(TSupply1.port_a, twinPipeGround.port_b1) annotation (Line(
      points={{16,-12},{12,-12},{12,-32},{8,-32}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(TReturn1.port_a, twinPipeGround.port_b2) annotation (Line(
      points={{-46,-72},{-20,-72},{-20,-44},{-12,-44}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(twinPipeGround.port_a2, boundary3.ports[1]) annotation (Line(
      points={{8,-44},{20,-44},{20,-72},{70,-72}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(boundary.ports[1], preinsulatedPipes.port_a1) annotation (Line(
      points={{-72,80},{-30,80},{-30,66},{-16,66}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(preinsulatedPipes.port_b1, TSupply.port_a) annotation (Line(
      points={{4,66},{10,66},{10,80},{16,80}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(TReturn.port_a, preinsulatedPipes.port_b2) annotation (Line(
      points={{-40,48},{-26,48},{-26,54},{-16,54}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(preinsulatedPipes.port_a2, boundary1.ports[1]) annotation (Line(
      points={{4,54},{12,54},{12,48},{72,48}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(TGround.y, preinsulatedPipes.Tg) annotation (Line(
      points={{-49,10},{-6,10},{-6,45.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TGround.y, twinPipeGround.Tg) annotation (Line(
      points={{-49,10},{-30,10},{-30,-64},{-2,-64},{-2,-52.2}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end PreinsulatedPipesExample;
