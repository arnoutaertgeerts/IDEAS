within IDEAS.DistrictHeating.Production.Examples;
model TestHeatpump
  extends Modelica.Icons.Example;

  Fluid.FixedResistances.Pipe_Insulated       pipe_Insulated(
    UA=10,
    m_flow_nominal=0.1,
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    m=1,
    dp_nominal=20)
         annotation (Placement(transformation(extent={{-10,-4},{10,4}},
        rotation=270,
        origin={84,40})));
  Modelica.Blocks.Sources.Constant const(k=300)
    annotation (Placement(transformation(extent={{20,-20},{0,0}})));
  Fluid.Movers.Pump pump(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=0.1)
    annotation (Placement(transformation(extent={{42,40},{62,60}})));
  Fluid.Sources.FixedBoundary bou(
    nPorts=2,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    use_T=false) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={82,-10})));
  Fluid.Sensors.TemperatureTwoPort genericT(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=0.1)
    annotation (Placement(transformation(extent={{6,40},{26,60}})));

  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=true)
    annotation (Placement(transformation(extent={{-54,-72},{-34,-52}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=293.15)
    annotation (Placement(transformation(extent={{20,70},{0,90}})));
  HeatPump heatPump
    annotation (Placement(transformation(extent={{-26,30},{-6,8}})));
  Fluid.Sources.FixedBoundary sink(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    use_T=false) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-80,42})));
  Fluid.Sources.MassFlowSource_T source(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,

    m_flow=0.1,
    T=303.15)
    annotation (Placement(transformation(extent={{-88,-10},{-68,10}})));
equation
  connect(pipe_Insulated.port_a,pump. port_b) annotation (Line(
      points={{84,50},{62,50}},
      color={0,127,255},
      smooth=Smooth.None));

  connect(bou.ports[1],pipe_Insulated. port_b) annotation (Line(
      points={{84,0},{84,30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(genericT.port_b,pump. port_a) annotation (Line(
      points={{26,50},{42,50}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pump.port_b, pipe_Insulated.port_a) annotation (Line(
      points={{62,50},{84,50}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(fixedTemperature.port, heatPump.heatPort) annotation (Line(
      points={{0,80},{-18,80},{-18,30}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(const.y, heatPump.TSet) annotation (Line(
      points={{-1,-10},{-17,-10},{-17,8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(heatPump.port_b, genericT.port_a) annotation (Line(
      points={{-5.8,24},{0,24},{0,50},{6,50}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(heatPump.port_a, pipe_Insulated.port_b) annotation (Line(
      points={{-5.8,16},{84,16},{84,30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(sink.ports[1], heatPump.brineOut) annotation (Line(
      points={{-70,42},{-48,42},{-48,24},{-26,24}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(source.ports[1], heatPump.brineIn) annotation (Line(
      points={{-68,0},{-48,0},{-48,16},{-26,16}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end TestHeatpump;
