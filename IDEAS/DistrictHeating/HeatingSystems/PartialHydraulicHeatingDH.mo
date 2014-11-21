within IDEAS.DistrictHeating.HeatingSystems;
partial model PartialHydraulicHeatingDH
  "Partial for hydraulic heating system coupled to substation of district heating system"
  replaceable package Medium =
    Modelica.Media.Water.ConstantPropertyLiquidWater;
  extends IDEAS.Interfaces.BaseClasses.HeatingSystem(
    isHea = true,
    isCoo = false,
    nConvPorts = nZones,
    nRadPorts = nZones,
    nTemSen = nZones,
    nEmbPorts=nZones,
    nLoads=1,
    nZones=1);
  // --- Paramter: General parameters for the design (nominal) conditions and heat curve
  parameter Modelica.SIunits.Power[nZones] QNom(each min=0) = ones(nZones)*5000
    "Nominal power, can be seen as the max power of the emission system per zone";
  parameter Boolean minSup=true
    "true to limit the supply temperature on the lower side";
    parameter Modelica.SIunits.Temperature TSupMin=273.15 + 30
    "Minimum supply temperature if enabled";
  parameter Modelica.SIunits.Temperature TSupNom=273.15 + 45
    "Nominal supply temperature";
  parameter Modelica.SIunits.TemperatureDifference dTSupRetNom=10
    "Nominal DT in the heating system";
  parameter Modelica.SIunits.Temperature[nZones] TRoomNom={294.15 for i in 1:
      nZones} "Nominal room temperature";
  parameter Modelica.SIunits.TemperatureDifference corFac_val = 0
    "correction term for TSet of the heating curve";
  parameter Modelica.SIunits.Time timeFilter=43200
    "Time constant for the filter of ambient temperature for computation of heating curve";
  final parameter Modelica.SIunits.MassFlowRate[nZones] m_flow_nominal = QNom/(4180.6*dTSupRetNom)
    "Nominal mass flow rates";
  // --- production components of hydraulic circuit
  // --- distribution components of hydraulic circuit
  IDEAS.Fluid.Movers.Pump[nZones] pumpRad(
    each useInput=true,
    each m=1,
    m_flow_nominal=m_flow_nominal,
    redeclare each package Medium = Medium,
    filteredMassFlowRate=true,
    riseTime=60)
              annotation (Placement(transformation(extent={{-12,12},{12,-12}},
        rotation=180,
        origin={-96,-36})));
  IDEAS.Fluid.FixedResistances.Pipe_Insulated pipeSupply(
    redeclare package Medium = Medium,
    m=1,
    UA=10,
    m_flow_nominal=sum(m_flow_nominal))
           annotation (Placement(transformation(extent={{-10,-4},{10,4}},
        rotation=270,
        origin={-20,6})));

  // --- emission components of hydraulic circuit
  replaceable IDEAS.Fluid.HeatExchangers.Radiators.Radiator[nZones] emission(
      each TInNom=TSupNom,
      each TOutNom=TSupNom - dTSupRetNom,
      TZoneNom=TRoomNom,
      QNom=QNom,
      each powerFactor=3.37,
    redeclare each package Medium = Medium) constrainedby
    IDEAS.Fluid.HeatExchangers.Interfaces.EmissionTwoPort
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-150,-36})));
  // --- boundaries
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=293.15)
    "fixed temperature to simulate heat losses of hydraulic components"
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={-132,-8})));
  // --- controllers
  replaceable IDEAS.Controls.Control_fixme.Hyst_NoEvent_Var[
                                                nZones] heatingControl(each uLow_val=
        22, each uHigh_val=20)
    "onoff controller for the pumps of the emission circuits"
    annotation (Placement(transformation(extent={{-102,-90},{-82,-70}})));
  Modelica.Blocks.Sources.RealExpression THigh_val[nZones](y=0.5*ones(nZones))
    "Higher boudary for set point temperature"
    annotation (Placement(transformation(extent={{-136,-78},{-122,-58}})));
  Modelica.Blocks.Sources.RealExpression TLow_val[nZones](y=-0.5*ones(nZones))
    "Lower boundary for set point temperature"
    annotation (Placement(transformation(extent={{-136,-102},{-122,-82}})));
  Modelica.Blocks.Math.Add add[nZones](each k1=-1, each k2=+1)
    annotation (Placement(transformation(extent={{-164,-90},{-144,-70}})));
  // --- Interface
  Modelica.Blocks.Interfaces.RealInput TSet[nZones](    final quantity="ThermodynamicTemperature",unit="K",displayUnit="degC")
    "Set point temperature for the zones" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-180,-114}),
                          iconTransformation(
        extent={{-14,-14},{14,14}},
        rotation=90,
        origin={-2,-104})));
  // --- Sensors

  IDEAS.Fluid.FixedResistances.Pipe_Insulated pipeReturn(
    redeclare package Medium = Medium,
    m=1,
    UA=10,
    m_flow_nominal=sum(m_flow_nominal)) annotation (Placement(transformation(
        extent={{10,4},{-10,-4}},
        rotation=180,
        origin={-60,80})));
  Fluid.FixedResistances.SplitterFixedResistanceDpM spl(
    redeclare package Medium = Medium,
    m_flow_nominal={sum(m_flow_nominal),sum(m_flow_nominal),-sum(m_flow_nominal)},
    dp_nominal={0,0,0})
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-110,80})));
  Controls.ControlHeating.HeatingCurve heatingCurve(
    dTOutHeaBal=0,
    TSup_nominal=343.15,
    TSupMin=318.15,
    TRet_nominal=293.15,
    TOut_nominal=273.15,
    use_TRoo_in=true)
    annotation (Placement(transformation(extent={{-124,12},{-104,32}})));
  IDEAS.Fluid.Sensors.TemperatureTwoPort senTemEm_in(redeclare package Medium
      = Medium, m_flow_nominal=sum(m_flow_nominal))
    "Inlet temperature of the emission system"
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-36,-36})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=sim.Te)
    annotation (Placement(transformation(extent={{-160,18},{-140,38}})));
  Fluid.FixedResistances.Pipe_Insulated[nZones] pipeReturnEmission(
    redeclare each package Medium = Medium,
    each m=1,
    each UA=10,
    m_flow_nominal=m_flow_nominal) annotation (Placement(transformation(
        extent={{10,4},{-10,-4}},
        rotation=270,
        origin={-172,54})));
  Fluid.Sensors.TemperatureTwoPort senTemEm_out1(
                                                redeclare package Medium =
        Medium, m_flow_nominal=sum(m_flow_nominal))
    "Outlet temperature of the emission system" annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-140,80})));
  Fluid.MixingVolumes.MixingVolume vol(
    redeclare package Medium = Medium,
    m_flow_nominal=sum(m_flow_nominal),
    V=sum(m_flow_nominal)*30/1000,
    nPorts=1 + nZones) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-170,90})));
  IDEAS.Fluid.Sources.FixedBoundary absolutePressure(redeclare package Medium
      = Medium, use_T=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-86,62})));
equation
  // connections that are function of the number of circuits
  for i in 1:nZones loop
    connect(pipeReturnEmission[i].heatPort, fixedTemperature.port) annotation (
      Line(
      points={{-168,54},{-132,54},{-132,2}},
      color={191,0,0},
      smooth=Smooth.None));
    connect(pumpRad[i].port_a, senTemEm_in.port_b) annotation (Line(
      points={{-84,-36},{-46,-36}},
      color={0,127,255},
      smooth=Smooth.None));
  end for;

  // general connections for any configuration
  connect(TSet, add.u2) annotation (Line(
      points={{-180,-114},{-180,-86},{-166,-86}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(add.y, heatingControl.u) annotation (Line(
      points={{-143,-80},{-104,-80}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TSensor, add.u1) annotation (Line(
      points={{-204,-60},{-174,-60},{-174,-74},{-166,-74}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(THigh_val.y, heatingControl.uHigh) annotation (Line(
      points={{-121.3,-68},{-114,-68},{-114,-73.2},{-104,-73.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TLow_val.y, heatingControl.uLow) annotation (Line(
      points={{-121.3,-92},{-114,-92},{-114,-87},{-104,-87}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(heatingControl.y, pumpRad.m_flowSet) annotation (Line(
      points={{-81,-80},{-72,-80},{-72,-58},{-114,-58},{-114,-16},{-96,-16},{-96,
          -23.52}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(TSet[1], heatingCurve.TRoo_in) annotation (Line(
      points={{-180,-114},{-180,16},{-125.9,16}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pipeSupply.port_b, senTemEm_in.port_a) annotation (Line(
      points={{-20,-4},{-20,-36},{-26,-36}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipeSupply.heatPort, fixedTemperature.port) annotation (Line(
      points={{-24,6},{-132,6},{-132,2}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(pipeReturn.heatPort, fixedTemperature.port) annotation (Line(
      points={{-60,76},{-60,6},{-132,6},{-132,2}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(realExpression.y, heatingCurve.TOut) annotation (Line(
      points={{-139,28},{-126,28}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(emission.port_a, pumpRad.port_b) annotation (Line(
      points={{-140,-36},{-108,-36}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipeReturnEmission.port_b, vol.ports[1:nZones]) annotation (Line(
      points={{-172,64},{-172,80},{-170,80}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(vol.ports[end], senTemEm_out1.port_a) annotation (Line(
      points={{-170,80},{-150,80}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(spl.port_2, pipeReturn.port_a) annotation (Line(
      points={{-100,80},{-70,80}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(spl.port_1, senTemEm_out1.port_b) annotation (Line(
      points={{-120,80},{-130,80}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipeReturnEmission.port_a, emission.port_b) annotation (Line(
      points={{-172,44},{-172,-36},{-160,-36}},
      color={0,127,255},
      smooth=Smooth.None));

  connect(vol.heatPort, fixedTemperature.port) annotation (Line(
      points={{-160,90},{-156,90},{-156,54},{-132,54},{-132,2}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(absolutePressure.ports[1], pipeReturn.port_a) annotation (Line(
      points={{-86,72},{-86,80},{-70,80}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -100},{200,100}}), graphics));
end PartialHydraulicHeatingDH;
