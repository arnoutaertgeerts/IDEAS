within IDEAS.DistrictHeating;
package Examples
  model SeriesGrid "District heating grid with buildings connected in series"
    Interfaces.Network network(
      redeclare Substations.SingleHeatExchanger endStation,
      redeclare Substations.SingleHeatExchanger substations,
      redeclare Production.Boiler production(boiler(from_dp=true)))
      annotation (Placement(transformation(extent={{-10,-8},{10,12}})));
  end SeriesGrid;

  model TestBoiler "Simple test example for boiler"
    IDEAS.Fluid.FixedResistances.Pipe_Insulated pipe_Insulated(
      UA=10,
      m_flow_nominal=0.1,
      redeclare package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater,
      m=1,
      dp_nominal=20)
           annotation (Placement(transformation(extent={{-10,-4},{10,4}},
          rotation=270,
          origin={44,32})));
    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=
          293.15)
      annotation (Placement(transformation(extent={{-50,-36},{-30,-16}})));
    Modelica.Blocks.Sources.Constant const(k=300)
      annotation (Placement(transformation(extent={{-82,44},{-62,64}})));
    Production.ModulatingProduction modulatingProduction(
      dp_nominal=20,
      redeclare package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater,
      QNom=1000,
      redeclare IDEAS.DistrictHeating.Production.Data.Boiler productionData,
      m_flow_nominal=0.01)
      annotation (Placement(transformation(extent={{-50,22},{-30,44}})));
    Fluid.Movers.Pump pump(redeclare package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=0.01)
      annotation (Placement(transformation(extent={{2,32},{22,52}})));
    Fluid.Sources.FixedBoundary bou(nPorts=1, redeclare package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater) annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-12,76})));
  equation
    connect(fixedTemperature.port, pipe_Insulated.heatPort) annotation (Line(
        points={{-30,-26},{2,-26},{2,32},{40,32}},
        color={191,0,0},
        smooth=Smooth.None));
    connect(const.y, modulatingProduction.TSet) annotation (Line(
        points={{-61,54},{-41,54},{-41,44}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(modulatingProduction.port_a, pipe_Insulated.port_b) annotation (
        Line(
        points={{-30,28},{-22,28},{-22,8},{44,8},{44,22}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(modulatingProduction.heatPort, pipe_Insulated.heatPort) annotation
      (Line(
        points={{-43,22},{-44,22},{-44,-4},{-4,-4},{-4,-28},{2,-28},{2,32},{40,
            32}},
        color={191,0,0},
        smooth=Smooth.None));
    connect(modulatingProduction.port_b, pump.port_a) annotation (Line(
        points={{-30,36},{-14,36},{-14,42},{2,42}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(pipe_Insulated.port_a, pump.port_b) annotation (Line(
        points={{44,42},{22,42}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(bou.ports[1], pump.port_a) annotation (Line(
        points={{-12,66},{-12,42},{2,42}},
        color={0,127,255},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}),      graphics));
  end TestBoiler;

  model TestGenericBoiler "Simple test example for boiler"
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
    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=
          293.15)
      annotation (Placement(transformation(extent={{-70,12},{-50,32}})));
    Modelica.Blocks.Sources.Constant const(k=300)
      annotation (Placement(transformation(extent={{-120,94},{-100,114}})));
    Fluid.Movers.Pump pump(redeclare package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=0.1)
      annotation (Placement(transformation(extent={{-36,82},{-16,102}})));
    Production.GenericModulatingProduction genericModulatingProduction(
      redeclare IDEAS.DistrictHeating.Production.Data.GenericBoiler
        productionData,
      redeclare package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater,
      dp_nominal=20,
      QNom=10000,
      m_flow_nominal=0.1)
      annotation (Placement(transformation(extent={{-100,68},{-80,90}})));
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
    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature1(
                                                                            T=
          293.15)
      annotation (Placement(transformation(extent={{14,-94},{34,-74}})));
    Modelica.Blocks.Sources.Constant const1(
                                           k=300)
      annotation (Placement(transformation(extent={{-84,-24},{-64,-4}})));
    Fluid.Production.Boiler boiler(
      dp_nominal=20,
      redeclare package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater,
      m_flow_nominal=0.1,
      modulationMin=10,
      modulationStart=20,
      QNom=10000)
      annotation (Placement(transformation(extent={{-28,-40},{-8,-18}})));
    Fluid.Sources.FixedBoundary bou(
      nPorts=2,
      redeclare package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater,
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
  equation
    connect(fixedTemperature.port, pipe_Insulated.heatPort) annotation (Line(
        points={{-50,22},{-22,22},{-22,68},{-10,68},{-10,82},{2,82}},
        color={191,0,0},
        smooth=Smooth.None));
    connect(pipe_Insulated.port_a, pump.port_b) annotation (Line(
        points={{6,92},{-16,92}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(genericModulatingProduction.port_a, pipe_Insulated.port_b)
      annotation (Line(
        points={{-80,74},{-62,74},{-62,60},{6,60},{6,72}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(const.y, genericModulatingProduction.TSet) annotation (Line(
        points={{-99,104},{-91,104},{-91,90}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(genericModulatingProduction.heatPort, pipe_Insulated.heatPort)
      annotation (Line(
        points={{-93,68},{-92,68},{-92,52},{-22,52},{-22,68},{-10,68},{-10,82},
            {2,82}},
        color={191,0,0},
        smooth=Smooth.None));
    connect(fixedTemperature1.port, pipe_Insulated1.heatPort) annotation (Line(
        points={{34,-84},{48,-84},{48,-24},{86,-24}},
        color={191,0,0},
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
    connect(genericModulatingProduction.port_b, genericT.port_a) annotation (
        Line(
        points={{-80,82},{-80,92},{-72,92}},
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
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-140,
              -100},{100,140}}),      graphics), Icon(coordinateSystem(extent={
              {-140,-100},{100,140}})));
  end TestGenericBoiler;
end Examples;
