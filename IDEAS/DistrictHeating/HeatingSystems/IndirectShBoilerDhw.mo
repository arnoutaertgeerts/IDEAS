within IDEAS.DistrictHeating.HeatingSystems;
model IndirectSHBoilerDHW
  //Extensions
  extends BaseClasses.PartialHeatExchanger(
    redeclare replaceable HydraulicCircuits.Mixer hydraulicCircuitPartial(
      redeclare package Medium1 = Medium,
      redeclare package Medium2 = Medium,
      m1_flow_nominal=m_flow_zone,
      m2_flow_nominal=m_flow_zone),
    redeclare Fluid.HeatExchangers.Radiators.Radiator emission,
    pipeSupply(m=1, UA=10),
    pipeReturn(m=1, UA=10),
    redeclare HydraulicCircuits.SinglePump hydraulicCircuitDHW,
    redeclare HydraulicCircuits.SinglePump
                                      hydraulicCircuitSH,
    redeclare Control.Hysteresis controlSH(
      release=false,
      uLow=21,
      uHigh=23,
      realTrue=0,
      realFalse=m_flow_zone),
    redeclare Control.MassFlowControl partialHXControl);

  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow[nZones](Q_flow=0)
                                                                            annotation (
     Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-170,80})));
  Fluid.Storage.StorageTank_OneIntHX storageTank_OneIntHX
    annotation (Placement(transformation(extent={{24,14},{58,62}})));
  replaceable Fluid.Domestic_Hot_Water.DHW_ProfileReader       dHW(
    profileType=3,
    redeclare package Medium = Medium,
    VDayAvg=sim.nOcc*0.045,
    TDHWSet=318.15,
    m_flow_nominal=0.1)
                   constrainedby IDEAS.Fluid.Domestic_Hot_Water.partial_DHW(
    redeclare package Medium = Medium,
    TDHWSet=TDHWSet) annotation (Placement(transformation(
        extent={{-10,8},{10,-8}},
        rotation=90,
        origin={96,34})));
  HydraulicCircuits.SinglePump direct annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={6,-6})));
  Control.Hysteresis hysteresis1
    annotation (Placement(transformation(extent={{-36,-16},{-16,4}})));
  HydraulicCircuits.Mixer mixer(
    redeclare package Medium1 = Medium,
    redeclare package Medium2 = Medium,
    m1_flow_nominal=m_flow_nominal,
    m2_flow_nominal=m_flow_nominal,
    TSup_nominal=323.15,
    TSupMin=313.15,
    TRet_nominal=303.15,
    TRoo_nominal=294.15,
    TOut_nominal=265.15)            annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-82,-12})));
  HydraulicCircuits.Splitter splitter annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-82,-38})));
  Fluid.Sources.FixedBoundary bou(
    use_T=false,
    redeclare package Medium = Medium,
    p=200000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-110,-36})));
equation
  connect(fixedHeatFlow.port, heatPortEmb) annotation (Line(
      points={{-180,80},{-186,80},{-186,60},{-200,60}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(storageTank_OneIntHX.port_a, dHW.port_cold) annotation (Line(
      points={{58,58.3077},{92,58.3077},{92,58},{92.3333,58},{92.3333,49.0952},
          {94.3333,49.0952}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(storageTank_OneIntHX.port_b, dHW.port_hot) annotation (Line(
      points={{58,17.6923},{94.3333,17.6923},{94.3333,29.0952}},
      color={0,127,255},
      smooth=Smooth.None));

  connect(direct.port_b1, storageTank_OneIntHX.portHXUpper) annotation (Line(
      points={{0,4},{0,28.7692},{24,28.7692}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(direct.port_a2, storageTank_OneIntHX.portHXLower) annotation (Line(
      points={{12,4},{12,21.3846},{24,21.3846}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(direct.u, hysteresis1.y) annotation (Line(
      points={{-5.4,-6},{-15.2,-6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(storageTank_OneIntHX.T[5], hysteresis1.u) annotation (Line(
      points={{58,43.3538},{62,43.3538},{62,72},{-44,72},{-44,-6},{-37.2,-6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(zoneSplitter.port_a, mixer.port_b1) annotation (Line(
      points={{-88,4.2},{-88,-2}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(zoneSplitter.port_b, mixer.port_a2) annotation (Line(
      points={{-76,4},{-76,-2}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(splitter.port_b1, mixer.port_a1) annotation (Line(
      points={{-88,-28},{-88,-22}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(heatExchanger.port_b1, splitter.port_a1) annotation (Line(
      points={{-88,-58},{-88,-48}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(splitter.port_a2, mixer.port_b2) annotation (Line(
      points={{-76,-28},{-76,-22}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(heatExchanger.port_a2, splitter.port_b2) annotation (Line(
      points={{-76,-58},{-76,-48}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(splitter.port_b3, direct.port_a1) annotation (Line(
      points={{-72,-34},{0,-34},{0,-16}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(splitter.port_a3, direct.port_b2) annotation (Line(
      points={{-72,-42},{12,-42},{12,-16}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(TSet[1], mixer.u) annotation (Line(
      points={{-160,-104},{-160,-92},{-152,-92},{-152,-12},{-93.4,-12}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(bou.ports[1], splitter.port_a1) annotation (Line(
      points={{-110,-46},{-110,-52},{-88,-52},{-88,-48}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(TSensor, controlSH.u) annotation (Line(
      points={{-204,-60},{-160,-60},{-160,40},{-127.2,40}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -100},{200,100}}), graphics));
end IndirectSHBoilerDHW;
