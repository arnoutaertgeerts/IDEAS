within IDEAS.DistrictHeating.Substations;
model SingleHeatExchanger "Substation with a single heat exchanger"
  //Extensions
  extends Interfaces.Baseclasses.Substation(
    flowPort_supply_out(redeclare package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater),
    flowPort_return_in(redeclare package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater),
    flowPort_sec_in(redeclare package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater),
    flowPort_sec_out(redeclare package Medium =
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
    annotation (Placement(transformation(extent={{-16,-70},{-36,-90}})));

  Fluid.Actuators.Valves.TwoWayLinear val(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal=0.1,
    dpValve_nominal=20)                   annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={72,0})));

  Modelica.Fluid.Sensors.TemperatureTwoPort temperature1(
                                                        redeclare package
      Medium = Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Sensor of the return temperature" annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={20,60})));
  outer SimInfoManager sim
    annotation (Placement(transformation(extent={{-98,80},{-78,100}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort Tsupply(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Sensor of the return temperature" annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-2,-40})));
  Fluid.HeatExchangers.ConstantEffectiveness hex(
    redeclare package Medium1 =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    redeclare package Medium2 =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    m1_flow_nominal=0.25,
    m2_flow_nominal=0.25,
    dp1_nominal=200,
    dp2_nominal=200)
    annotation (Placement(transformation(extent={{-10,10},{10,30}})));
  Fluid.Sensors.MassFlowRate senMasFlo1(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-20,76})));
  Control.SupplyTControl supplyTControl
    annotation (Placement(transformation(extent={{54,60},{74,80}})));
  IDEAS.Fluid.FixedResistances.SplitterFixedResistanceDpM spl2(
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal={0.25,-0.25,-0.25},
    dp_nominal={20,-20,-20}) "Splitter for bypass"
    annotation (Placement(transformation(extent={{62,-30},{82,-50}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort TReturn(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Sensor of the return temperature" annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={40,-80})));
equation
  //Connections
  connect(flowPort_supply_in, flowPort_supply_in) annotation (Line(
      points={{100,-40},{100,-40}},
      color={0,0,0},
      smooth=Smooth.None));

  connect(spl1.port_2, flowPort_return_in) annotation (Line(
      points={{-36,-80},{-100,-80}},
      color={0,127,255},
      smooth=Smooth.None));

  connect(hex.port_b2, spl1.port_3) annotation (Line(
      points={{-10,14},{-26,14},{-26,-70}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(hex.port_a2, val.port_b) annotation (Line(
      points={{10,14},{72,14},{72,10}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(temperature1.port_b, flowPort_sec_in[1]) annotation (Line(
      points={{20,70},{20,100}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(hex.port_b1, temperature1.port_a) annotation (Line(
      points={{10,26},{20,26},{20,50}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(flowPort_sec_out[1], senMasFlo1.port_a) annotation (Line(
      points={{-20,100},{-20,86}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(senMasFlo1.port_b, hex.port_a1) annotation (Line(
      points={{-20,66},{-20,26},{-10,26}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(temperature1.T, supplyTControl.sensTemp) annotation (Line(
      points={{31,60},{42,60},{42,64},{53.4,64}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(senMasFlo1.m_flow, supplyTControl.sensFlow) annotation (Line(
      points={{-9,76},{22,76},{22,75.8},{53.6,75.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(supplyTControl.y, val.y) annotation (Line(
      points={{74.6,70},{80,70},{80,40},{40,40},{40,8.88178e-016},{60,
          8.88178e-016}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(val.port_a, spl2.port_3) annotation (Line(
      points={{72,-10},{72,-30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(spl2.port_2, flowPort_supply_in) annotation (Line(
      points={{82,-40},{100,-40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(Tsupply.port_a, spl2.port_1) annotation (Line(
      points={{8,-40},{62,-40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(TReturn.port_b, flowPort_return_out) annotation (Line(
      points={{50,-80},{100,-80}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(spl1.port_1, TReturn.port_a) annotation (Line(
      points={{-16,-80},{30,-80}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(Tsupply.port_b, flowPort_supply_out) annotation (Line(
      points={{-12,-40},{-100,-40}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end SingleHeatExchanger;
