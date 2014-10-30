within IDEAS.DistrictHeating;
model Example

  inner IDEAS.SimInfoManager sim(occBeh=false, DHW=false)
    annotation (Placement(transformation(extent={{-92,74},{-72,94}})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{-68,76},{-48,96}})));
  IDEAS.Interfaces.Building building(
    redeclare IDEAS.Interfaces.BaseClasses.CausalInhomeFeeder inHomeGrid,
    redeclare IDEAS.VentilationSystems.None ventilationSystem,
    DH=true,
    redeclare Buildings.Examples.BaseClasses.structure building,
    redeclare IDEAS.Occupants.Standards.None occupant(TSet_val=296.15),
    redeclare IDEAS.HeatingSystems.Heating_Radiators_DH heatingSystem(
        dTSupRetNom=20, TSupNom=318.15))
             annotation (Placement(transformation(extent={{-18,22},{2,42}})));
  IDEAS.DistrictHeating.Substations.SingleHeatExchanger hXWithBypass
    annotation (Placement(transformation(extent={{-18,-26},{2,-6}})));
  Fluid.FixedResistances.Pipe_Insulated pipe_Insulated(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    dp_nominal=10000,
    m_flow_nominal=0.25,
    UA=250,
    from_dp=true)
            annotation (Placement(transformation(extent={{20,-2},{40,6}})));

  Fluid.FixedResistances.Pipe_Insulated pipe_Insulated1(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    dp_nominal=10000,
    m_flow_nominal=0.25,
    UA=250,
    from_dp=true)
            annotation (Placement(transformation(extent={{22,-34},{42,-26}})));

  Fluid.Movers.FlowMachine_dp fan1(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    motorCooledByFluid=false,
    m_flow_nominal=0.5)            annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={62,2})));

  IDEAS.Interfaces.Building building1(
    redeclare Occupants.Standards.None                             occupant(TSet_val=
          296.15),
    redeclare IDEAS.Interfaces.BaseClasses.CausalInhomeFeeder inHomeGrid,
    redeclare IDEAS.VentilationSystems.None ventilationSystem,
    DH=true,
    redeclare Buildings.Examples.BaseClasses.structure building,
    redeclare IDEAS.HeatingSystems.Heating_Radiators_DH heatingSystem(
        dTSupRetNom=20, TSupNom=318.15))
             annotation (Placement(transformation(extent={{-78,22},{-58,42}})));
  IDEAS.DistrictHeating.Substations.SingleHeatExchanger hXWithBypass1
    annotation (Placement(transformation(extent={{-78,-26},{-58,-6}})));
  Fluid.FixedResistances.Pipe_Insulated pipe_Insulated2(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal=0.25,
    UA=50,
    from_dp=true,
    dp_nominal=10)
           annotation (Placement(transformation(extent={{-46,-10},{-26,-2}})));

  Fluid.FixedResistances.Pipe_Insulated pipe_Insulated3(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal=0.25,
    UA=50,
    from_dp=true,
    dp_nominal=10)
           annotation (Placement(transformation(extent={{-46,-30},{-26,-22}})));

  Modelica.Blocks.Sources.Constant const(k=100000)
    annotation (Placement(transformation(extent={{28,-70},{48,-50}})));
  Fluid.Sources.FixedBoundary bou(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    use_T=false,
    p=100000)
    annotation (Placement(transformation(extent={{-20,-68},{0,-48}})));

  Production.ModulatingProduction boiler(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,

    QNom=30000,
    m_flow_nominal=0.1,
    redeclare IDEAS.DistrictHeating.Production.Data.GenericBoiler
      productionData) annotation (Placement(transformation(
        extent={{-10,11},{10,-11}},
        rotation=180,
        origin={84,-13})));

  Modelica.Blocks.Sources.Constant const1(k=343)
    annotation (Placement(transformation(extent={{54,28},{74,48}})));
equation
  connect(hXWithBypass.flowPort_supply_in, pipe_Insulated.port_a) annotation (
      Line(
      points={{2,-20},{2,2},{20,2}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(hXWithBypass.flowPort_return_out, pipe_Insulated1.port_a) annotation (
     Line(
      points={{2,-24},{2,-30},{22,-30}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(pipe_Insulated.port_b, fan1.port_b) annotation (Line(
      points={{40,2},{52,2}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(hXWithBypass1.flowPort_supply_in, pipe_Insulated2.port_a) annotation (
     Line(
      points={{-58,-20},{-52,-20},{-52,-6},{-46,-6}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(hXWithBypass.flowPort_supply_out, pipe_Insulated2.port_b) annotation (
     Line(
      points={{-18,-20},{-22,-20},{-22,-6},{-26,-6}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(hXWithBypass1.flowPort_return_out, pipe_Insulated3.port_a)
    annotation (Line(
      points={{-58,-24},{-52,-24},{-52,-26},{-46,-26}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(hXWithBypass.flowPort_return_in, pipe_Insulated3.port_b) annotation (
      Line(
      points={{-18,-24},{-22,-24},{-22,-26},{-26,-26}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(fan1.dp_in, const.y) annotation (Line(
      points={{62.2,-10},{62,-10},{62,-60},{49,-60}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pipe_Insulated1.port_a, bou.ports[1]) annotation (Line(
      points={{22,-30},{12,-30},{12,-58},{0,-58}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(hXWithBypass1.flowPort_b1[1], building1.port_return) annotation (Line(
      points={{-70,-6},{-70,22},{-69.6,22}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(hXWithBypass1.flowPort_a1[1], building1.port_supply) annotation (Line(
      points={{-66,-6},{-66,22.1},{-66.7,22.1}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(hXWithBypass.flowPort_b1[1], building.port_return) annotation (Line(
      points={{-10,-6},{-10,8},{-10,22},{-9.6,22}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(hXWithBypass.flowPort_a1[1], building.port_supply) annotation (Line(
      points={{-6,-6},{-6,8},{-6,22.1},{-6.7,22.1}},
      color={0,0,0},
      smooth=Smooth.None));

  //BoilerViaPartials.TSet = sim.Te;
  connect(fan1.port_a, boiler.port_b) annotation (Line(
      points={{72,2},{74,2},{74,-8}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipe_Insulated1.port_b, boiler.port_a) annotation (Line(
      points={{42,-30},{58,-30},{58,-16},{74,-16}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(const1.y, boiler.TSet) annotation (Line(
      points={{75,38},{85,38},{85,0}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-140,
            -100},{100,100}}),      graphics), Icon(coordinateSystem(extent={{-140,
            -100},{100,100}})));
end Example;