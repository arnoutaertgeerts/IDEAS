within IDEAS.DistrictHeating.Production.Examples;
model TestGenericBoiler "Simple test example for boiler"
  extends Modelica.Icons.Example;

  IDEAS.Fluid.FixedResistances.Pipe_Insulated pipe_Insulated(
    UA=10,
    m_flow_nominal=0.1,
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    m=1,
    dp_nominal=20)
         annotation (Placement(transformation(extent={{-10,-4},{10,4}},
        rotation=270,
        origin={6,82})));
  Modelica.Blocks.Sources.Constant const(k=300)
    annotation (Placement(transformation(extent={{-136,84},{-116,104}})));
  Fluid.Movers.Pump pump(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=0.1)
    annotation (Placement(transformation(extent={{-36,82},{-16,102}})));

  IDEAS.Fluid.FixedResistances.Pipe_Insulated pipe_Insulated1(
    UA=10,
    m_flow_nominal=0.1,
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    m=1,
    dp_nominal=20)
         annotation (Placement(transformation(extent={{-10,-4},{10,4}},
        rotation=270,
        origin={90,-24})));
  Modelica.Blocks.Sources.Constant const1(
                                         k=300)
    annotation (Placement(transformation(extent={{-84,-24},{-64,-4}})));
  Fluid.Production.Boiler boiler(
    dp_nominal=20,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal=0.1,
    modulationMin=10,
    modulationStart=20,
    QNom=10000)
    annotation (Placement(transformation(extent={{-28,-40},{-8,-18}})));

  Fluid.Sources.FixedBoundary bou(
    nPorts=2,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    use_T=false) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={16,42})));

  Fluid.Movers.Pump pump1(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=0.1)
    annotation (Placement(transformation(extent={{44,-8},{64,12}})));
  Fluid.Sensors.TemperatureTwoPort genericT(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=0.1)
    annotation (Placement(transformation(extent={{-72,82},{-52,102}})));
  Fluid.Sensors.TemperatureTwoPort boilerT(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=0.1)
    annotation (Placement(transformation(extent={{0,-6},{20,14}})));
  PerformanceMapProduction iPTable3DProduction(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    dp_nominal=20,
    QNom=10000,
    m_flow_nominal=0.1,
    redeclare IDEAS.DistrictHeating.Production.Data.PerformanceMaps.Boiler data)
    annotation (Placement(transformation(extent={{-114,52},{-94,74}})));

  inner SimInfoManager sim
    annotation (Placement(transformation(extent={{-100,120},{-80,140}})));
  Modelica.Thermal.HeatTransfer.Celsius.PrescribedTemperature
    prescribedTemperature
    annotation (Placement(transformation(extent={{-114,8},{-94,28}})));
  Modelica.Thermal.HeatTransfer.Celsius.PrescribedTemperature
    prescribedTemperature1
    annotation (Placement(transformation(extent={{-56,-92},{-36,-72}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=sim.Te - 273.15)
    annotation (Placement(transformation(extent={{-140,-52},{-120,-32}})));
equation
  connect(pipe_Insulated.port_a, pump.port_b) annotation (Line(
      points={{6,92},{-16,92}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(boiler.port_a, pipe_Insulated1.port_b) annotation (Line(
      points={{-8,-34},{18,-34},{18,-42},{90,-42},{90,-34}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(const1.y, boiler.TSet) annotation (Line(
      points={{-63,-14},{-19,-14},{-19,-18}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(boiler.heatPort, pipe_Insulated1.heatPort) annotation (Line(
      points={{-21,-40},{-18,-40},{-18,-56},{48,-56},{48,-24},{86,-24}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(bou.ports[1], pipe_Insulated.port_b) annotation (Line(
      points={{18,32},{18,20},{-4,20},{-4,60},{6,60},{6,72}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(bou.ports[2], pipe_Insulated1.port_b) annotation (Line(
      points={{14,32},{24,32},{24,-42},{90,-42},{90,-34}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pump1.port_b, pipe_Insulated1.port_a) annotation (Line(
      points={{64,2},{90,2},{90,-14}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(genericT.port_b, pump.port_a) annotation (Line(
      points={{-52,92},{-36,92}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(boiler.port_b, boilerT.port_a) annotation (Line(
      points={{-8,-26},{-4,-26},{-4,4},{0,4}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pump1.port_a, boilerT.port_b) annotation (Line(
      points={{44,2},{32,2},{32,4},{20,4}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(iPTable3DProduction.port_a, pipe_Insulated.port_b) annotation (Line(
      points={{-93.8,66},{6,66},{6,72}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(iPTable3DProduction.port_b, genericT.port_a) annotation (Line(
      points={{-93.8,58},{-80,58},{-80,92},{-72,92}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(const.y, iPTable3DProduction.TSet) annotation (Line(
      points={{-115,94},{-105,94},{-105,74}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(iPTable3DProduction.heatPort, pipe_Insulated.heatPort) annotation (
      Line(
      points={{-108,52},{-108,40},{-22,40},{-22,68},{0,68},{0,82},{2,82}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(prescribedTemperature.port, pipe_Insulated.heatPort) annotation (Line(
      points={{-94,18},{-80,18},{-80,40},{-22,40},{-22,68},{0,68},{0,82},{2,82}},
      color={191,0,0},
      smooth=Smooth.None));

  connect(prescribedTemperature1.port, pipe_Insulated1.heatPort) annotation (
      Line(
      points={{-36,-82},{6,-82},{6,-56},{48,-56},{48,-24},{86,-24}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(realExpression.y, prescribedTemperature.T) annotation (Line(
      points={{-119,-42},{-114,-42},{-114,-40},{-116,-40},{-116,18}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(realExpression.y, prescribedTemperature1.T) annotation (Line(
      points={{-119,-42},{-112,-42},{-112,-52},{-58,-52},{-58,-82}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-140,
            -100},{100,140}}),      graphics), Icon(coordinateSystem(extent={{-140,
            -100},{100,140}})));
end TestGenericBoiler;
