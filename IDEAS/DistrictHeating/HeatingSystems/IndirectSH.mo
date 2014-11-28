within IDEAS.DistrictHeating.HeatingSystems;
model IndirectSH
  //Extensions
  extends BaseClasses.PartialHeatExchanger(
    redeclare replaceable package Medium = IDEAS.Media.Water.Simple,
    redeclare Fluid.HeatExchangers.Radiators.Radiator emission(TInNom=323.15,
        TOutNom=303.15),
    pipeSupply(m=1, UA=10),
    pipeReturn(m=1, UA=10),
    redeclare HydraulicCircuits.SinglePump
                                      hydraulicCircuitSH(
      m1_flow_nominal=m_flow_zone,
      m2_flow_nominal=m_flow_zone,
      redeclare package Medium1 = Medium,
      redeclare package Medium2 = Medium),
    redeclare Control.Hysteresis controlSH(
      release=false,
      uLow=273.15 + 21,
      uHigh=273.15 + 23,
      realTrue=0,
      realFalse=m_flow_zone),
    heatExchanger(
      redeclare package Medium1 = Medium,
      redeclare package Medium2 = Medium,
      m1_flow_nominal=m_flow_nominal,
      m2_flow_nominal=m_flow_nominal,
      efficiency=0.9,
      m=1,
      p=200000,
      dp1_nominal=20000000,
      dp2_nominal=200));

  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow[nZones](Q_flow=0)
                                                                            annotation (
     Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-180,60})));
  Control.Hysteresis hysteresis(
    release=true,
    uLow=273.15 + 68,
    realTrue=0,
    realFalse=1,
    uHigh=273.15 + 70)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-118,-80})));
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
        origin={-82,-14})));
  Fluid.Sources.FixedBoundary bou(
    use_T=false,
    redeclare package Medium = Medium,
    p=200000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-116,-28})));
equation
  QHeaSys = -sum(emission.heatPortCon.Q_flow) - sum(emission.heatPortRad.Q_flow);
  P[1] = 0;
  Q[1] = 0;

  connect(fixedHeatFlow.port, heatPortEmb) annotation (Line(
      points={{-190,60},{-200,60}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(TSensor, controlSH.u) annotation (Line(
      points={{-204,-60},{-152,-60},{-152,40},{-127.2,40}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(zoneSplitter.port_a, mixer.port_b1) annotation (Line(
      points={{-88,4.2},{-88,-4}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(zoneSplitter.port_b, mixer.port_a2) annotation (Line(
      points={{-76,4},{-76,-4}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(TSet[1], mixer.u) annotation (Line(
      points={{-160,-104},{-160,-66},{-144,-66},{-144,-14},{-93.4,-14}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(heatExchanger.supplyT, hysteresis.u) annotation (Line(
      points={{-92.8,-54},{-136,-54},{-136,-80},{-129.2,-80}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(hysteresis.y, heatExchanger.u) annotation (Line(
      points={{-107.2,-80},{-102,-80},{-102,-58},{-93.4,-58}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(mixer.port_a1, heatExchanger.port_b1) annotation (Line(
      points={{-88,-24},{-88,-48}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(mixer.port_b2, heatExchanger.port_a2) annotation (Line(
      points={{-76,-24},{-76,-48}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(bou.ports[1], heatExchanger.port_b1) annotation (Line(
      points={{-116,-38},{-116,-42},{-88,-42},{-88,-48}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(heatExchanger.senM, hysteresis.u1) annotation (Line(
      points={{-92.6,-50},{-118,-50},{-118,-69.2}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -100},{200,100}}), graphics));
end IndirectSH;
