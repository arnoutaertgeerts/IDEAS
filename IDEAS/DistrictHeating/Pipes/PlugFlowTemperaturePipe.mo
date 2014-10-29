within IDEAS.DistrictHeating.Pipes;
model PlugFlowTemperaturePipe
  extends Modelica.Icons.Example;
  import IDEAS;

  inner Modelica.Fluid.System system(p_ambient=101325)
                                   annotation (Placement(transformation(extent={{72,132},
            {92,152}},         rotation=0)));

  IDEAS.Fluid.Movers.Pump pump1(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=1)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-146,22})));
  IDEAS.Fluid.Sensors.TemperatureTwoPort senTem2(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=0.1)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-106,22})));
  IDEAS.Fluid.Sensors.TemperatureTwoPort MSL100T(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=0.1)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-10,22})));
  IDEAS.Fluid.Sources.FixedBoundary bou2(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    nPorts=3,
    p=100000,
    T=373.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-194,22})));

  IDEAS.Fluid.Sources.FixedBoundary bou3(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    use_T=false,
    use_p=true,
    p=100000,
    nPorts=3) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={42,22})));

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
        Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.ConstantFlowHeatTransfer
        (alpha0=10))
    annotation (Placement(transformation(extent={{-68,12},{-48,32}})));

  IDEAS.Fluid.Movers.Pump pump2(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=1)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-146,-56})));
  IDEAS.Fluid.Sensors.TemperatureTwoPort senTem4(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=0.1)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-106,-56})));
  IDEAS.Fluid.Sensors.TemperatureTwoPort MSL10T(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=0.1)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-10,-56})));
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
        Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.ConstantFlowHeatTransfer
        (alpha0=10))
    annotation (Placement(transformation(extent={{-68,-66},{-48,-46}})));

  IDEAS.Fluid.Movers.Pump pump3(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=1)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-146,86})));
  IDEAS.Fluid.Sensors.TemperatureTwoPort senTem6(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=0.1)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-108,86})));
  IDEAS.Fluid.Sensors.TemperatureTwoPort PlugFlowT(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=0.1)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-8,86})));
  IDEAS.DistrictHeating.Pipes.PlugFlowHeatPort plugFlowHeatPort(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    pipeLength=32,
    pipeDiameter=0.1,
    dp_nominal=0,
    plugFlowPipe1(redeclare package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater),
    m_flow_nominal=0.1,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
    dynamicBalance=true)
    annotation (Placement(transformation(extent={{-68,76},{-48,96}})));

  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature[2] T2(T=293.15)
    annotation (Placement(transformation(extent={{-136,118},{-116,138}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature[100] T100(T=293.15)
    annotation (Placement(transformation(extent={{-88,42},{-68,62}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature[10] T10(T=293.15)
    annotation (Placement(transformation(extent={{-88,-28},{-68,-8}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor thermalResistor[2](R=0.01)
    annotation (Placement(transformation(extent={{-96,118},{-76,138}})));
  IDEAS.Fluid.Movers.Pump pump4(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=1)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-140,-130})));
  IDEAS.Fluid.Sensors.TemperatureTwoPort senTem1(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=0.1)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-100,-130})));
  IDEAS.Fluid.Sensors.TemperatureTwoPort MSL2T(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=0.1)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-4,-130})));
  Modelica.Fluid.Pipes.DynamicPipe pipe2(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
    momentumDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
    diameter=0.1,
    length=32,
    use_HeatTransfer=true,
    redeclare model HeatTransfer =
        Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.ConstantFlowHeatTransfer
        (alpha0=10),
    nNodes=2)
    annotation (Placement(transformation(extent={{-62,-140},{-42,-120}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature[2] T1(T=293.15)
    annotation (Placement(transformation(extent={{-82,-106},{-62,-86}})));
  IDEAS.Fluid.Sources.FixedBoundary bou1(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    nPorts=1,
    p=100000,
    T=373.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-188,-130})));
  IDEAS.Fluid.Sources.FixedBoundary bou4(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    use_T=false,
    use_p=true,
    p=100000,
    nPorts=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={54,-130})));
equation
  connect(pump1.port_b, senTem2.port_a) annotation (Line(
      points={{-136,22},{-116,22}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senTem2.port_b, pipe.port_a) annotation (Line(
      points={{-96,22},{-68,22}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(MSL100T.port_a, pipe.port_b) annotation (Line(
      points={{-20,22},{-48,22}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pump2.port_b,senTem4. port_a) annotation (Line(
      points={{-136,-56},{-116,-56}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senTem4.port_b, pipe1.port_a) annotation (Line(
      points={{-96,-56},{-68,-56}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(MSL10T.port_a, pipe1.port_b) annotation (Line(
      points={{-20,-56},{-48,-56}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pump3.port_b,senTem6. port_a) annotation (Line(
      points={{-136,86},{-118,86}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pump3.port_a, bou2.ports[1]) annotation (Line(
      points={{-156,86},{-184,86},{-184,24.6667}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pump1.port_a, bou2.ports[2]) annotation (Line(
      points={{-156,22},{-184,22}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pump2.port_a, bou2.ports[3]) annotation (Line(
      points={{-156,-56},{-184,-56},{-184,19.3333}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(PlugFlowT.port_b, bou3.ports[1]) annotation (Line(
      points={{2,86},{32,86},{32,19.3333}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(MSL100T.port_b, bou3.ports[2]) annotation (Line(
      points={{0,22},{32,22}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(MSL10T.port_b, bou3.ports[3]) annotation (Line(
      points={{0,-56},{32,-56},{32,24.6667}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senTem6.port_b, plugFlowHeatPort.port_a) annotation (Line(
      points={{-98,86},{-68,86}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(PlugFlowT.port_a, plugFlowHeatPort.port_b) annotation (Line(
      points={{-18,86},{-48,86}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(T100.port, pipe.heatPorts) annotation (Line(
      points={{-68,52},{-57.9,52},{-57.9,26.4}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(T10.port, pipe1.heatPorts) annotation (Line(
      points={{-68,-18},{-57.9,-18},{-57.9,-51.6}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(T2.port, thermalResistor.port_a) annotation (Line(
      points={{-116,128},{-96,128}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(thermalResistor.port_b, plugFlowHeatPort.heatPort1) annotation (Line(
      points={{-76,128},{-58,128},{-58,96}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(pump4.port_b,senTem1. port_a) annotation (Line(
      points={{-130,-130},{-110,-130}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senTem1.port_b,pipe2. port_a) annotation (Line(
      points={{-90,-130},{-62,-130}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(MSL2T.port_a, pipe2.port_b) annotation (Line(
      points={{-14,-130},{-42,-130}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(T1.port, pipe2.heatPorts) annotation (Line(
      points={{-62,-96},{-51.9,-96},{-51.9,-125.6}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(pump4.port_a, bou1.ports[1]) annotation (Line(
      points={{-150,-130},{-178,-130}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(MSL2T.port_b, bou4.ports[1]) annotation (Line(
      points={{6,-130},{44,-130}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-220,
            -160},{100,160}}), graphics), Icon(coordinateSystem(extent={{-220,-160},
            {100,160}})));
end PlugFlowTemperaturePipe;
