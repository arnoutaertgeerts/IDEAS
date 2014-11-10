within IDEAS.DistrictHeating.Production.Examples;
model PolynomialProductionSpeed
  //Extensions
  extends Modelica.Icons.Example;

  PolynomialProduction polynomialProduction(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    QNom=10000,
    m_flow_nominal=0.1,
    redeclare IDEAS.DistrictHeating.Production.Data.Polynomials.Boiler data,
    beta={1.10801352268,-0.00139459489796,7.84565873015e-05,-0.00560282142857,-4.15816326533e-07,
        3.9307142857e-07,1.587e-05,-3.86712018138e-08,-4.29261904761e-07,2.67019047619e-05},
    powers={{2,0,0,0},{1,1,0,0},{1,0,1,0},{1,0,0,1},{0,2,0,0},{0,1,1,0},{0,1,0,1},
        {0,0,2,0},{0,0,1,1},{0,0,0,2}},
    dp_nominal=0)
    annotation (Placement(transformation(extent={{-44,16},{-24,38}})));
  Modelica.Blocks.Sources.Constant TSet(k=273 + 60)
    annotation (Placement(transformation(extent={{-92,-30},{-72,-10}})));
  inner SimInfoManager sim
    annotation (Placement(transformation(extent={{-86,38},{-66,58}})));
  Fluid.Movers.Pump pump(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=0.1)
    annotation (Placement(transformation(extent={{-24,-12},{-4,8}})));
  Fluid.FixedResistances.Pipe_Insulated pipe(
    UA=10,
    m_flow_nominal=0.1,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    m=1,
    dp_nominal=20) annotation (Placement(transformation(
        extent={{10,-4},{-10,4}},
        rotation=270,
        origin={58,12})));
  Fluid.Sources.FixedBoundary bou(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    use_T=false) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={82,-2})));
  Modelica.Thermal.HeatTransfer.Celsius.PrescribedTemperature
    prescribedTemperature
    annotation (Placement(transformation(extent={{8,38},{28,58}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=sim.Te - 273.15)
    annotation (Placement(transformation(extent={{-22,38},{-2,58}})));
  Fluid.Sensors.TemperatureTwoPort senPoly(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=0.1)
    annotation (Placement(transformation(extent={{8,-12},{28,8}})));
equation
  connect(TSet.y,polynomialProduction. TSet) annotation (Line(
      points={{-71,-20},{-54,-20},{-54,46},{-35,46},{-35,38}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(polynomialProduction.port_b,pump. port_a) annotation (Line(
      points={{-23.8,22},{-24,22},{-24,-2}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(polynomialProduction.port_a,pipe. port_b) annotation (Line(
      points={{-23.8,30},{58,30},{58,22}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(bou.ports[1],pipe. port_a) annotation (Line(
      points={{82,-12},{82,-18},{42,-18},{42,-2},{58,-2},{58,2}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(realExpression.y,prescribedTemperature. T) annotation (Line(
      points={{-1,48},{6,48}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(prescribedTemperature.port,pipe. heatPort) annotation (Line(
      points={{28,48},{38,48},{38,12},{54,12}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(pump.port_b,senPoly. port_a) annotation (Line(
      points={{-4,-2},{8,-2}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senPoly.port_b,pipe. port_a) annotation (Line(
      points={{28,-2},{58,-2},{58,2}},
      color={0,127,255},
      smooth=Smooth.None));
end PolynomialProductionSpeed;
