within IDEAS.DistrictHeating;
package Examples
  extends Modelica.Icons.ExamplesPackage;

  model SeriesGrid "District heating grid with buildings connected in series"
    import IDEAS;

    extends Modelica.Icons.Example;

    Interfaces.DHConnection dHConnection(redeclare
        IDEAS.DistrictHeating.Pipes.DoublePipes.TwinPipeGround
        districtHeatingPipe, redeclare package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater)
      annotation (Placement(transformation(extent={{-44,8},{-24,24}})));
    IDEAS.Interfaces.BuildingDH
                              building1(
      redeclare Occupants.Standards.None                             occupant(TSet_val=
            296.15),
      redeclare IDEAS.Interfaces.BaseClasses.CausalInhomeFeeder inHomeGrid,
      redeclare IDEAS.VentilationSystems.None ventilationSystem,
      DH=true,
      redeclare Buildings.Examples.BaseClasses.structure building,
      redeclare IDEAS.DistrictHeating.HeatingSystems.DirectSh heatingSystem)
               annotation (Placement(transformation(extent={{-44,34},{-24,54}})));
    Modelica.Blocks.Sources.Constant TGround(k=273 + 8)
      annotation (Placement(transformation(extent={{-64,-32},{-44,-12}})));
    IDEAS.Fluid.Sources.FixedBoundary absolutePressure(
                  use_T=false,
      nPorts=1,
      redeclare package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=90,
          origin={6,-28})));
  equation
    connect(building1.flowPortReturnOut,dHConnection. flowPortIn) annotation (
        Line(
        points={{-36,34.2},{-36,24}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(dHConnection.flowPortOut,building1. flowPortSupplyIn) annotation (
        Line(
        points={{-32,24},{-32,34.2}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(TGround.y,dHConnection. TAmbient) annotation (Line(
        points={{-43,-22},{-36,-22},{-36,7}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(dHConnection.flowPort_supply_out, dHConnection.flowPort_return_in)
      annotation (Line(
        points={{-44,18},{-48,18},{-48,14},{-44,14}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(dHConnection.flowPort_supply_in, dHConnection.flowPort_return_out)
      annotation (Line(
        points={{-24,18},{-4,18},{-4,14},{-24,14}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(absolutePressure.ports[1], dHConnection.flowPort_return_out)
      annotation (Line(
        points={{6,-18},{6,16},{-4,16},{-4,14},{-24,14}},
        color={0,127,255},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
              -100,-100},{100,100}}), graphics));
  end SeriesGrid;

  model Example
    extends Modelica.Icons.Example;

    inner IDEAS.SimInfoManager sim(occBeh=false, DHW=false)
      annotation (Placement(transformation(extent={{-50,60},{-30,80}})));
    inner Modelica.Fluid.System system
      annotation (Placement(transformation(extent={{20,60},{40,80}})));
    IDEAS.Interfaces.Building building(
      redeclare IDEAS.Interfaces.BaseClasses.CausalInhomeFeeder inHomeGrid,
      redeclare IDEAS.VentilationSystems.None ventilationSystem,
      DH=true,
      redeclare Buildings.Examples.BaseClasses.structure building,
      redeclare IDEAS.Occupants.Standards.None occupant(TSet_val=296.15),
      redeclare IDEAS.HeatingSystems.Heating_Radiators_DH heatingSystem(
          dTSupRetNom=20, TSupNom=318.15),
      numberOfConnections=1)
               annotation (Placement(transformation(extent={{-20,42},{0,62}})));
    IDEAS.DistrictHeating.Substations.SingleHeatExchanger hXWithBypass
      annotation (Placement(transformation(extent={{-20,-4},{0,16}})));

    Fluid.Movers.FlowMachine_dp fan1(
      redeclare package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater,
      motorCooledByFluid=false,
      m_flow_nominal=0.5)            annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={60,20})));

    IDEAS.Interfaces.Building building1(
      redeclare Occupants.Standards.None                             occupant(TSet_val=
            296.15),
      redeclare IDEAS.Interfaces.BaseClasses.CausalInhomeFeeder inHomeGrid,
      redeclare IDEAS.VentilationSystems.None ventilationSystem,
      DH=true,
      redeclare Buildings.Examples.BaseClasses.structure building,
      redeclare IDEAS.HeatingSystems.Heating_Radiators_DH heatingSystem(
          dTSupRetNom=20, TSupNom=318.15),
      numberOfConnections=1)
               annotation (Placement(transformation(extent={{-80,42},{-60,62}})));
    IDEAS.DistrictHeating.Substations.SingleHeatExchanger hXWithBypass1
      annotation (Placement(transformation(extent={{-80,-4},{-60,16}})));

    Modelica.Blocks.Sources.Constant const(k=1e5)
      annotation (Placement(transformation(extent={{20,-60},{40,-40}})));
    Fluid.Sources.FixedBoundary bou(
      redeclare package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater,
      use_T=false,
      p=100000,
      nPorts=1)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=270,
          origin={80,40})));

    Production.PolynomialProduction boiler(
      redeclare package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater,
      QNom=30000,
      m_flow_nominal=0.1,
      redeclare
        IDEAS.DistrictHeating.Production.Data.Polynomials.Boiler2ndDegree data,
      dp_nominal=200)   annotation (Placement(transformation(
          extent={{-10,-11},{10,11}},
          rotation=180,
          origin={90,5})));

    Modelica.Blocks.Sources.Constant const1(k=343)
      annotation (Placement(transformation(extent={{60,-80},{80,-60}})));
    Modelica.Blocks.Sources.Constant TGround(k=273 + 7)
      annotation (Placement(transformation(extent={{-76,-40},{-56,-20}})));
    Pipes.DoublePipes.TwinPipeGround twinPipeGround(
      redeclare package Medium1 =
          Modelica.Media.Water.ConstantPropertyLiquidWater,
      redeclare package Medium2 =
          Modelica.Media.Water.ConstantPropertyLiquidWater,
      L=100,
      rho=1000,
      lambdaG=1.5,
      lambdaI=0.026,
      H=1.5,
      E=0.35,
      Do=0.16,
      Di=0.16,
      Dc=0.5,
      m1_flow_nominal=0.1,
      m2_flow_nominal=0.1,
      dp_nominal=200)
      annotation (Placement(transformation(extent={{-30,-14},{-50,14}})));
    Pipes.DoublePipes.TwinPipeGround twinPipeGround1(
      redeclare package Medium1 =
          Modelica.Media.Water.ConstantPropertyLiquidWater,
      redeclare package Medium2 =
          Modelica.Media.Water.ConstantPropertyLiquidWater,
      L=100,
      rho=1000,
      lambdaG=1.5,
      lambdaI=0.026,
      H=1.5,
      E=0.35,
      Do=0.16,
      Di=0.16,
      Dc=0.5,
      m1_flow_nominal=0.1,
      m2_flow_nominal=0.1,
      dp_nominal=200)
      annotation (Placement(transformation(extent={{32,-14},{12,14}})));
  equation
    connect(fan1.dp_in, const.y) annotation (Line(
        points={{60.2,8},{60,8},{60,-50},{41,-50}},
        color={0,0,127},
        smooth=Smooth.None));

    //BoilerViaPartials.TSet = sim.Te;
    connect(const1.y, boiler.TSet) annotation (Line(
        points={{81,-70},{91,-70},{91,-8}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(fan1.port_a, boiler.port_b) annotation (Line(
        points={{70,20},{79.8,20},{79.8,8}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(building1.port_in, hXWithBypass1.flowPort_sec_out) annotation (Line(
        points={{-71.6,42},{-72,42},{-72,16}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(building1.port_out, hXWithBypass1.flowPort_sec_in) annotation (Line(
        points={{-68.4,42},{-68,42},{-68,16}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(building.port_in, hXWithBypass.flowPort_sec_out) annotation (Line(
        points={{-11.6,42},{-12,42},{-12,16}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(building.port_out, hXWithBypass.flowPort_sec_in) annotation (Line(
        points={{-8.4,42},{-8,42},{-8,16}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(bou.ports[1], boiler.port_b) annotation (Line(
        points={{80,30},{80,20},{79.8,20},{79.8,8}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(hXWithBypass.flowPort_supply_out, twinPipeGround.port_a1)
      annotation (Line(
        points={{-20,2},{-20,6},{-30,6}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(twinPipeGround.port_b1, hXWithBypass1.flowPort_supply_in)
      annotation (Line(
        points={{-50,6},{-60,6},{-60,2}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(hXWithBypass1.flowPort_return_out, twinPipeGround.port_a2)
      annotation (Line(
        points={{-60,-2},{-60,-6},{-50,-6}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(twinPipeGround.port_b2, hXWithBypass.flowPort_return_in)
      annotation (Line(
        points={{-30,-6},{-20,-6},{-20,-2}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(TGround.y, twinPipeGround.Tg) annotation (Line(
        points={{-55,-30},{-40,-30},{-40,-14.2}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(hXWithBypass.flowPort_supply_in, twinPipeGround1.port_b1)
      annotation (Line(
        points={{0,2},{0,6},{12,6}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(hXWithBypass.flowPort_return_out, twinPipeGround1.port_a2)
      annotation (Line(
        points={{0,-2},{0,-6},{12,-6}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(twinPipeGround1.port_a1, fan1.port_b) annotation (Line(
        points={{32,6},{40,6},{40,20},{50,20}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(twinPipeGround1.port_b2, boiler.port_a) annotation (Line(
        points={{32,-6},{79.8,-6},{79.8,1.33227e-015}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(TGround.y, twinPipeGround1.Tg) annotation (Line(
        points={{-55,-30},{22,-30},{22,-14.2}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}),      graphics), Icon(coordinateSystem(extent={{-100,
              -100},{100,100}})),
      experiment(StopTime=1e+006, Interval=3600),
      __Dymola_experimentSetupOutput);
  end Example;

  model Example2 "Extension of example 1, including distribution heat losses"
    extends Examples.Example(
      fan1(addPowerToMedium=false),
      pipe_Insulated(m=100),
      pipe_Insulated1(m=100),
      pipe_Insulated3(m=100),
      pipe_Insulated2(m=100),
      pipe_Insulated4(m=100));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
      prescribedTemperature
      annotation (Placement(transformation(extent={{-106,-84},{-86,-64}})));
    Modelica.Blocks.Sources.RealExpression realExpression(y=sim.Tground)
      annotation (Placement(transformation(extent={{-136,-86},{-116,-66}})));
  equation
    connect(realExpression.y, prescribedTemperature.T) annotation (Line(
        points={{-115,-76},{-112,-76},{-112,-74},{-108,-74}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-140,
              -100},{100,100}}), graphics));
  end Example2;

  model ExampleDHConnections
    import IDEAS;
    extends Modelica.Icons.Example;

    inner IDEAS.SimInfoManager sim(occBeh=false, DHW=false)
      annotation (Placement(transformation(extent={{40,80},{60,100}})));
    inner Modelica.Fluid.System system
      annotation (Placement(transformation(extent={{80,80},{100,100}})));
    IDEAS.Interfaces.BuildingDH nbuilding(
      redeclare IDEAS.Interfaces.BaseClasses.CausalInhomeFeeder inHomeGrid,
      redeclare IDEAS.VentilationSystems.None ventilationSystem,
      redeclare Buildings.Examples.BaseClasses.structure building,
      redeclare IDEAS.Occupants.Standards.None occupant(TSet_val=296.15),
      redeclare IDEAS.DistrictHeating.HeatingSystems.IndirectSH heatingSystem(
          heatExchanger(dp1_nominal(displayUnit="Pa") = 200, dp2_nominal(
              displayUnit="Pa") = 200)))
               annotation (Placement(transformation(extent={{-48,26},{-28,46}})));

    Production.PolynomialProduction boiler(
      redeclare
        IDEAS.DistrictHeating.Production.Data.Polynomials.Boiler2ndDegree data,
      m_flow_nominal=0.5,
      dp_nominal=200,
      redeclare package Medium = IDEAS.Media.Water.Simple,
      QNom(displayUnit="kW") = 30000)
                        annotation (Placement(transformation(
          extent={{-10,-11},{10,11}},
          rotation=180,
          origin={80,5})));

    Modelica.Blocks.Sources.Constant const1(k=273 + 70)
      annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
    Interfaces.DHConnection dHConnection(redeclare
        IDEAS.DistrictHeating.Pipes.DoublePipes.TwinPipeGround
        districtHeatingPipe,
      m_flow_nominal=0.5,
      Tsupply(allowFlowReversal=false),
      TReturn(allowFlowReversal=false),
      redeclare package Medium = IDEAS.Media.Water.Simple)
      annotation (Placement(transformation(extent={{-74,0},{-54,16}})));
    Interfaces.DHConnection dHConnection1(redeclare
        IDEAS.DistrictHeating.Pipes.DoublePipes.TwinPipeGround
        districtHeatingPipe,
      m_flow_nominal=0.5,
      redeclare package Medium = IDEAS.Media.Water.Simple)
      annotation (Placement(transformation(extent={{-48,0},{-28,16}})));
    IDEAS.Interfaces.BuildingDH
                              building1(
      redeclare Occupants.Standards.None                             occupant(TSet_val=
            296.15),
      redeclare IDEAS.Interfaces.BaseClasses.CausalInhomeFeeder inHomeGrid,
      redeclare IDEAS.VentilationSystems.None ventilationSystem,
      redeclare Buildings.Examples.BaseClasses.structure building,
      redeclare IDEAS.DistrictHeating.HeatingSystems.DirectSH heatingSystem)
               annotation (Placement(transformation(extent={{-74,26},{-54,46}})));
    Modelica.Fluid.Sensors.TemperatureTwoPort supply(       m_flow_nominal=0.5,
        redeclare package Medium = IDEAS.Media.Water.Simple)
      annotation (Placement(transformation(extent={{60,18},{40,38}})));
    Modelica.Fluid.Sensors.TemperatureTwoPort returnT(redeclare package Medium
        = IDEAS.Media.Water.Simple)
      annotation (Placement(transformation(extent={{20,-26},{40,-6}})));
    IDEAS.Fluid.Movers.FlowMachine_dp
                                fan1(
      motorCooledByFluid=false,
      m_flow_nominal=0.5,
      addPowerToMedium=false,
      redeclare package Medium = IDEAS.Media.Water.Simple)
                                     annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={10,28})));
    Modelica.Blocks.Sources.Constant const2(k=1e5)
      annotation (Placement(transformation(extent={{-28,-40},{-8,-20}})));
    Modelica.Fluid.Sources.FixedBoundary boundary(
      redeclare package Medium = IDEAS.Media.Water.Simple,
      use_T=false,
      h=0,
      nPorts=1)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=270,
          origin={50,0})));
  equation

    //BoilerViaPartials.TSet = sim.Te;
    connect(const1.y, boiler.TSet) annotation (Line(
        points={{61,-40},{81,-40},{81,-8}},
        color={0,0,127},
        smooth=Smooth.None));

    connect(returnT.port_b, boiler.port_a) annotation (Line(
        points={{40,-16},{69.8,-16},{69.8,0}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(dHConnection.flowPort_supply_in, dHConnection1.flowPort_supply_out)
      annotation (Line(
        points={{-54,10},{-48,10}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(supply.port_a, boiler.port_b) annotation (Line(
        points={{60,28},{69.8,28},{69.8,8}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(dHConnection.flowPort_return_out, dHConnection1.flowPort_return_in)
      annotation (Line(
        points={{-54,6},{-48,6}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(dHConnection1.flowPort_return_out, returnT.port_a) annotation (Line(
        points={{-28,6},{0,6},{0,-16},{20,-16}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(supply.port_b, fan1.port_a) annotation (Line(
        points={{40,28},{20,28}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(fan1.port_b, dHConnection1.flowPort_supply_in) annotation (Line(
        points={{0,28},{-22,28},{-22,10},{-28,10}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(const2.y, fan1.dp_in) annotation (Line(
        points={{-7,-30},{10.2,-30},{10.2,16}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(building1.flowPortReturnOut, dHConnection.flowPortIn) annotation (
        Line(
        points={{-66,26.2},{-66,16}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(building1.flowPortSupplyIn, dHConnection.flowPortOut) annotation (
        Line(
        points={{-62,26.2},{-62,16}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(nbuilding.flowPortReturnOut, dHConnection1.flowPortIn) annotation (
        Line(
        points={{-40,26.2},{-40,16}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(nbuilding.flowPortSupplyIn, dHConnection1.flowPortOut) annotation (
        Line(
        points={{-36,26.2},{-36,16}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(boundary.ports[1], returnT.port_b) annotation (Line(
        points={{50,-10},{50,-16},{40,-16}},
        color={0,127,255},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}),      graphics), Icon(coordinateSystem(extent={{-100,
              -100},{100,100}})),
      experiment(StopTime=1e+006, Interval=3600),
      __Dymola_experimentSetupOutput);
  end ExampleDHConnections;
end Examples;
