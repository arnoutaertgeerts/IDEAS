within IDEAS.DistrictHeating.HeatingSystems;
model IndirectSH
  //Extensions
  extends BaseClasses.PartialHeatExchanger(
    redeclare replaceable package Medium = IDEAS.Media.Water.Simple,
    redeclare Fluid.HeatExchangers.Radiators.Radiator emission,
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
      p=200000,
      efficiency=0.9,
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
    m2_flow_nominal=m_flow_nominal) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-82,-20})));
  Fluid.Sources.FixedBoundary bou(
    nPorts=1,
    use_T=false,
    redeclare package Medium = Medium,
    p=200000)
    annotation (Placement(transformation(extent={{-120,-50},{-100,-30}})));
equation
  QHeaSys = -sum(emission.heatPortCon.Q_flow) - sum(emission.heatPortRad.Q_flow);
  P[1] = 0;
  Q[1] = 0;

  connect(fixedHeatFlow.port, heatPortEmb) annotation (Line(
      points={{-190,60},{-200,60}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(TSensor, controlSH.u) annotation (Line(
      points={{-204,-60},{-152,-60},{-152,36},{-127.2,36}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(zoneSplitter.port_a, mixer.port_b1) annotation (Line(
      points={{-88,0.2},{-88,-10}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(zoneSplitter.port_b, mixer.port_a2) annotation (Line(
      points={{-76,0},{-76,-10}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(TSet[1], mixer.u) annotation (Line(
      points={{-160,-104},{-160,-66},{-144,-66},{-144,-20},{-93.4,-20}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(heatExchanger.port_b1, mixer.port_a1) annotation (Line(
      points={{-88,-54},{-88,-30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(heatExchanger.port_a2, mixer.port_b2) annotation (Line(
      points={{-76,-54},{-76,-30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(heatExchanger.m, hysteresis.u1) annotation (Line(
      points={{-92.6,-56},{-118,-56},{-118,-69.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(heatExchanger.supplyT, hysteresis.u) annotation (Line(
      points={{-92.8,-60},{-136,-60},{-136,-80},{-129.2,-80}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(hysteresis.y, heatExchanger.u) annotation (Line(
      points={{-107.2,-80},{-102,-80},{-102,-64},{-93.4,-64}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(bou.ports[1], mixer.port_a1) annotation (Line(
      points={{-100,-40},{-88,-40},{-88,-30}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -100},{200,100}}), graphics));
end IndirectSH;
