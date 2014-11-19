within IDEAS.DistrictHeating.Pipes.Examples;
model PreinsulatedPipesExample

  //Extensions
  extends Modelica.Icons.Example;

  Modelica.Fluid.Sources.FixedBoundary returnsink(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    use_T=false,
    T=343.15)
    annotation (Placement(transformation(extent={{-92,-30},{-72,-10}})));

  Modelica.Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow=0.2,
    T=343.15,
    nPorts=1) annotation (Placement(transformation(extent={{-92,30},{-72,50}})));

  Modelica.Fluid.Sources.MassFlowSource_T boundary1(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow=0.2,
    T=318.15,
    nPorts=1) annotation (Placement(transformation(extent={{90,-30},{70,-10}})));

  Modelica.Fluid.Sources.FixedBoundary supplysink(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    use_T=false,
    T=343.15) annotation (Placement(transformation(extent={{90,30},{70,50}})));

  Fluid.Sensors.TemperatureTwoPort TReturn(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=0.1)
    annotation (Placement(transformation(extent={{-46,-30},{-66,-10}})));
  Fluid.Sensors.TemperatureTwoPort TSupply(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=0.1)
    annotation (Placement(transformation(extent={{16,30},{36,50}})));
  Fluid.Sensors.SpecificEnthalpyTwoPort hReturnOut(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=0.1)
    annotation (Placement(transformation(extent={{-22,-30},{-42,-10}})));
  Fluid.Sensors.SpecificEnthalpyTwoPort hReturnIn(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=0.1)
    annotation (Placement(transformation(extent={{52,-30},{32,-10}})));
  Fluid.Sensors.SpecificEnthalpyTwoPort hSupplyIn(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=0.1)
    annotation (Placement(transformation(extent={{-54,30},{-34,50}})));
  Fluid.Sensors.SpecificEnthalpyTwoPort hSupplyOut(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=0.1)
    annotation (Placement(transformation(extent={{44,30},{64,50}})));
  PreinsulatedPipes preinsulatedPipe(
    redeclare package Medium1 =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    redeclare package Medium2 =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    m1_flow_nominal=0.1,
    m2_flow_nominal=0.1,
    L=100,
    rho=1000,
    lambdaCasing=60,
    Hr=1.28,
    E=0.73,
    lambdaGround=1.5,
    lambdaInsulation=0.0265,
    Dp=0.0889,
    Dc=0.1578) annotation (Placement(transformation(extent={{-12,2},{8,26}})));
  Modelica.Blocks.Sources.Constant TGround(k=273 + 12)
    annotation (Placement(transformation(extent={{-36,-70},{-16,-50}})));
equation
  connect(hReturnOut.port_b, TReturn.port_a) annotation (Line(
      points={{-42,-20},{-46,-20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(boundary1.ports[1], hReturnIn.port_a) annotation (Line(
      points={{70,-20},{52,-20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(boundary.ports[1], hSupplyIn.port_a) annotation (Line(
      points={{-72,40},{-54,40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(TSupply.port_b, hSupplyOut.port_a) annotation (Line(
      points={{36,40},{44,40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(hSupplyOut.port_b, supplysink.ports[1]) annotation (Line(
      points={{64,40},{70,40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(returnsink.ports[1], TReturn.port_b) annotation (Line(
      points={{-72,-20},{-66,-20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(TGround.y, preinsulatedPipe.Tg) annotation (Line(
      points={{-15,-60},{-2,-60},{-2,1.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(hReturnOut.port_a, preinsulatedPipe.port_b2) annotation (Line(
      points={{-22,-20},{-20,-20},{-20,8},{-12,8}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(preinsulatedPipe.port_a2, hReturnIn.port_b) annotation (Line(
      points={{8,8},{20,8},{20,-20},{32,-20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(TSupply.port_a, preinsulatedPipe.port_b1) annotation (Line(
      points={{16,40},{12,40},{12,20},{8,20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(hSupplyIn.port_b, preinsulatedPipe.port_a1) annotation (Line(
      points={{-34,40},{-20,40},{-20,20},{-12,20}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end PreinsulatedPipesExample;
