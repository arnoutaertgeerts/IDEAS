within IDEAS.DistrictHeating.Substations;
model ParallelHeatExchanger
  "Substation with two heat exchangers in a parallel configuration"
  import Buildings;
  //Extensions
  extends Interfaces.Baseclasses.Substation(
    numberOfConnections = 2,
    flowPort_supply_out(redeclare package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater),
    flowPort_return_in(redeclare package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater),
    flowPort_b1(redeclare package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater),
    flowPort_a1(redeclare package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater),
    flowPort_supply_in(redeclare package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater),
    flowPort_return_out(redeclare package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater));

  //Components
  IDEAS.Fluid.FixedResistances.SplitterFixedResistanceDpM spl1(
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal={0.25,-0.25,-0.25},
    dp_nominal={20,-20,-20}) "Splitter for bypass"
    annotation (Placement(transformation(extent={{-52,-70},{-72,-90}})));
  IDEAS.Fluid.FixedResistances.SplitterFixedResistanceDpM spl2(
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal={0.25,-0.25,-0.25},
    dp_nominal={20,-20,-20}) "Splitter for bypass"
    annotation (Placement(transformation(extent={{82,-30},{62,-50}})));

  Fluid.Actuators.Valves.TwoWayLinear val(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal=0.1,
    dpValve_nominal=20)                   annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={72,-4})));

  Modelica.Fluid.Sensors.TemperatureTwoPort temperature1(
                                                        redeclare package
      Medium = Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Sensor of the return temperature" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-28,36})));
  outer SimInfoManager sim
    annotation (Placement(transformation(extent={{-98,80},{-78,100}})));
  Fluid.HeatExchangers.ConstantEffectiveness hex(
    redeclare package Medium1 =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    redeclare package Medium2 =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    m1_flow_nominal=0.25,
    m2_flow_nominal=0.25,
    dp1_nominal=200,
    dp2_nominal=200)
    annotation (Placement(transformation(extent={{-62,10},{-42,30}})));
  Fluid.Sensors.MassFlowRate senMasFlo1(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-62,48})));
  Control.SupplyTControl supplyTControl
    annotation (Placement(transformation(extent={{-2,32},{18,52}})));
  IDEAS.Fluid.FixedResistances.SplitterFixedResistanceDpM spl3(
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal={0.25,-0.25,-0.25},
    dp_nominal={20,-20,-20}) "Splitter for bypass"
    annotation (Placement(transformation(extent={{-14,-70},{-34,-90}})));
  IDEAS.Fluid.FixedResistances.SplitterFixedResistanceDpM spl4(
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal={0.25,-0.25,-0.25},
    dp_nominal={20,-20,-20}) "Splitter for bypass"
    annotation (Placement(transformation(extent={{50,-30},{30,-50}})));
  Fluid.HeatExchangers.ConstantEffectiveness hex1(
    redeclare package Medium1 =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    redeclare package Medium2 =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    m1_flow_nominal=0.25,
    m2_flow_nominal=0.25,
    dp1_nominal=200,
    dp2_nominal=200)
    annotation (Placement(transformation(extent={{-4,-6},{16,14}})));
  Fluid.Actuators.Valves.TwoWayLinear val1(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal=0.1,
    dpValve_nominal=20)                   annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={40,-14})));
equation
  //Connections
  connect(flowPort_supply_in, flowPort_supply_in) annotation (Line(
      points={{100,-40},{100,-40}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(spl2.port_1, flowPort_supply_in) annotation (Line(
      points={{82,-40},{100,-40}},
      color={0,127,255},
      smooth=Smooth.None));

  connect(spl1.port_2, flowPort_return_in) annotation (Line(
      points={{-72,-80},{-100,-80}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(spl2.port_3, val.port_a) annotation (Line(
      points={{72,-30},{72,-14}},
      color={0,127,255},
      smooth=Smooth.None));

  connect(temperature1.port_b, hex.port_b1) annotation (Line(
      points={{-28,26},{-42,26}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(hex.port_b2, spl1.port_3) annotation (Line(
      points={{-62,14},{-62,-70}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(hex.port_a2, val.port_b) annotation (Line(
      points={{-42,14},{72,14},{72,6}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senMasFlo1.port_b, hex.port_a1) annotation (Line(
      points={{-62,38},{-62,26}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(temperature1.T, supplyTControl.sensTemp) annotation (Line(
      points={{-17,36},{-2.6,36}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(supplyTControl.y, val.y) annotation (Line(
      points={{18.6,42},{50,42},{50,22},{50,22},{50,-4},{60,-4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(spl1.port_1, spl3.port_2) annotation (Line(
      points={{-52,-80},{-34,-80}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(spl2.port_2, spl4.port_1) annotation (Line(
      points={{62,-40},{62,-40},{58,-40},{58,-40},{50,-40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(flowPort_supply_out, spl4.port_2) annotation (Line(
      points={{-100,-40},{30,-40}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(spl3.port_1, flowPort_return_out) annotation (Line(
      points={{-14,-80},{20,-80},{20,-80},{46,-80},{46,-80},{100,-80}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(spl3.port_3, hex1.port_b2) annotation (Line(
      points={{-24,-70},{-24,-2},{-4,-2}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(val1.port_a, spl4.port_3) annotation (Line(
      points={{40,-24},{40,-30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(hex1.port_a2, val1.port_b) annotation (Line(
      points={{16,-2},{40,-2},{40,-4}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(temperature1.port_a, flowPort_a1[1]) annotation (Line(
      points={{-28,46},{-28,60},{0,60},{0,100},{20,100},{20,96},{20,96},{20,96},
          {20,95}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senMasFlo1.port_a, flowPort_b1[1]) annotation (Line(
      points={{-62,58},{-62,100},{-20,100},{-20,95}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senMasFlo1.m_flow, supplyTControl.sensFlow) annotation (Line(
      points={{-51,48},{-4,48},{-4,47.8},{-2.4,47.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(hex1.port_b1, flowPort_a1[2]) annotation (Line(
      points={{16,10},{36,10},{36,88},{34,88},{20,88},{20,105}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(hex1.port_a1, flowPort_b1[2]) annotation (Line(
      points={{-4,10},{-12,10},{-12,105},{-20,105}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end ParallelHeatExchanger;
