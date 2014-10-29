within IDEAS.DistrictHeating.Pipes;
model PlugFlowTemperaturePipe
  extends Modelica.Icons.Example;
  import IDEAS;

  inner Modelica.Fluid.System system(p_ambient=101325)
                                   annotation (Placement(transformation(extent={{60,120},
            {80,140}},         rotation=0)));

  IDEAS.Fluid.Movers.Pump pump1(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=1)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-158,10})));
  IDEAS.Fluid.Sensors.TemperatureTwoPort senTem2(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=0.1)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-118,10})));
  IDEAS.Fluid.Sensors.TemperatureTwoPort MSL100T(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=0.1)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-22,10})));
  IDEAS.Fluid.Sources.FixedBoundary bou2(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    nPorts=3,
    p=100000,
    T=373.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-206,10})));

  IDEAS.Fluid.Sources.FixedBoundary bou3(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    use_T=false,
    use_p=true,
    p=100000,
    nPorts=3) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={30,10})));

  Modelica.Fluid.Pipes.DynamicPipe pipe(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
    momentumDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
    nNodes=100,
    diameter=0.1,
    length=32,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
    use_HeatTransfer=true,
    redeclare model HeatTransfer =
        Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.ConstantFlowHeatTransfer)
    annotation (Placement(transformation(extent={{-80,0},{-60,20}})));

  IDEAS.Fluid.Movers.Pump pump2(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=1)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-158,-68})));
  IDEAS.Fluid.Sensors.TemperatureTwoPort senTem4(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=0.1)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-118,-68})));
  IDEAS.Fluid.Sensors.TemperatureTwoPort MSL10T(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=0.1)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-22,-68})));
  Modelica.Fluid.Pipes.DynamicPipe pipe1(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
    momentumDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
    nNodes=10,
    diameter=0.1,
    length=32,
    use_HeatTransfer=true,
    redeclare model HeatTransfer =
        Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer)
    annotation (Placement(transformation(extent={{-80,-78},{-60,-58}})));

  IDEAS.Fluid.Movers.Pump pump3(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=1)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-158,74})));
  IDEAS.Fluid.Sensors.TemperatureTwoPort senTem6(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=0.1)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-120,74})));
  IDEAS.Fluid.Sensors.TemperatureTwoPort PlugFlowT(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=0.1)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-20,74})));
  IDEAS.DistrictHeating.Pipes.PlugFlowHeatPort plugFlowHeatPort(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,

    pipeLength=32,
    pipeDiameter=0.1,
    dp_nominal=0)
    annotation (Placement(transformation(extent={{-80,64},{-60,84}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=293.15)
    annotation (Placement(transformation(extent={{-100,86},{-80,106}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature[100] T100(T=293.15)
    annotation (Placement(transformation(extent={{-100,30},{-80,50}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature[10] T10(T=293.15)
    annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
equation
  connect(pump1.port_b, senTem2.port_a) annotation (Line(
      points={{-148,10},{-128,10}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senTem2.port_b, pipe.port_a) annotation (Line(
      points={{-108,10},{-80,10}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(MSL100T.port_a, pipe.port_b) annotation (Line(
      points={{-32,10},{-60,10}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pump2.port_b,senTem4. port_a) annotation (Line(
      points={{-148,-68},{-128,-68}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senTem4.port_b, pipe1.port_a) annotation (Line(
      points={{-108,-68},{-80,-68}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(MSL10T.port_a, pipe1.port_b) annotation (Line(
      points={{-32,-68},{-60,-68}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pump3.port_b,senTem6. port_a) annotation (Line(
      points={{-148,74},{-130,74}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pump3.port_a, bou2.ports[1]) annotation (Line(
      points={{-168,74},{-196,74},{-196,12.6667}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pump1.port_a, bou2.ports[2]) annotation (Line(
      points={{-168,10},{-196,10}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pump2.port_a, bou2.ports[3]) annotation (Line(
      points={{-168,-68},{-196,-68},{-196,7.33333}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(PlugFlowT.port_b, bou3.ports[1]) annotation (Line(
      points={{-10,74},{20,74},{20,7.33333}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(MSL100T.port_b, bou3.ports[2]) annotation (Line(
      points={{-12,10},{20,10}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(MSL10T.port_b, bou3.ports[3]) annotation (Line(
      points={{-12,-68},{20,-68},{20,12.6667}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senTem6.port_b, plugFlowHeatPort.port_a) annotation (Line(
      points={{-110,74},{-80,74}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(PlugFlowT.port_a, plugFlowHeatPort.port_b) annotation (Line(
      points={{-30,74},{-60,74}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(fixedTemperature.port, plugFlowHeatPort.heatPort) annotation (Line(
      points={{-80,96},{-70,96},{-70,84}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(T100.port, pipe.heatPorts) annotation (Line(
      points={{-80,40},{-69.9,40},{-69.9,14.4}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(T10.port, pipe1.heatPorts) annotation (Line(
      points={{-80,-30},{-69.9,-30},{-69.9,-63.6}},
      color={191,0,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-220,
            -100},{100,160}}), graphics), Icon(coordinateSystem(extent={{-220,-100},
            {100,160}})));
end PlugFlowTemperaturePipe;
