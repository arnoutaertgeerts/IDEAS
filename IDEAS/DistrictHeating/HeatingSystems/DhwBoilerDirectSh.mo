within IDEAS.DistrictHeating.HeatingSystems;
model DhwBoilerDirectSh
  extends IDEAS.DistrictHeating.HeatingSystems.PartialHydraulicHeatingDH(
      redeclare Fluid.HeatExchangers.Radiators.Radiator emission);

  Fluid.Storage.StorageTank_OneIntHX storageTank_OneIntHX
    annotation (Placement(transformation(extent={{40,-68},{78,-6}})));
  Fluid.FixedResistances.SplitterFixedResistanceDpM spl1(
    redeclare package Medium = Medium,
    m_flow_nominal={sum(m_flow_nominal),sum(m_flow_nominal),-sum(m_flow_nominal)},
    dp_nominal={0,0,0})
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},
        rotation=180,
        origin={0,80})));
  Fluid.Domestic_Hot_Water.DHW_ProfileReader dHW_ProfileReader annotation (
      Placement(transformation(
        extent={{12,-7},{-12,7}},
        rotation=270,
        origin={98,-45})));
  Fluid.Movers.Pump pump(useInput=true, m_flow_nominal=m_flow_storage)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={28,20})));
  Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=TDhwLow, uHigh=TDhwHigh)
    annotation (Placement(transformation(extent={{98,10},{78,30}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal
    annotation (Placement(transformation(extent={{66,10},{46,30}})));
  Fluid.FixedResistances.Pipe_Insulated       pipeSupply1(
    redeclare package Medium = Medium,
    m=1,
    UA=10,
    m_flow_nominal=sum(m_flow_nominal))
           annotation (Placement(transformation(extent={{-10,4},{10,-4}},
        rotation=90,
        origin={0,-8})));
  Fluid.FixedResistances.Pipe_Insulated       pipeSupply2(
    redeclare package Medium = Medium,
    m=1,
    UA=10,
    m_flow_nominal=sum(m_flow_nominal))
           annotation (Placement(transformation(extent={{-10,4},{10,-4}},
        rotation=90,
        origin={28,-22})));
  Fluid.Sources.FixedBoundary       absolutePressure1(
                                                     redeclare package Medium
      = Medium, use_T=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={126,-20})));
  Fluid.FixedResistances.SplitterFixedResistanceDpM spl2(
    redeclare package Medium = Medium,
    m_flow_nominal={sum(m_flow_nominal),sum(m_flow_nominal),-sum(m_flow_nominal)},
    dp_nominal={0,0,0})
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},
        rotation=90,
        origin={28,60})));
equation
  connect(spl1.port_2, portDhwOut) annotation (Line(
      points={{10,80},{20,80},{20,100}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipeReturn1.port_b, spl1.port_1) annotation (Line(
      points={{-50,80},{-10,80}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(storageTank_OneIntHX.port_a, dHW_ProfileReader.port_cold) annotation (
     Line(
      points={{78,-10.7692},{100,-10.7692},{100,-34}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(storageTank_OneIntHX.port_b, dHW_ProfileReader.port_hot) annotation (
      Line(
      points={{78,-63.2308},{100,-63.2308},{100,-58}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(hysteresis.y, booleanToReal.u) annotation (Line(
      points={{77,20},{68,20}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(pump.m_flowSet, booleanToReal.y) annotation (Line(
      points={{38.4,20},{45,20}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(storageTank_OneIntHX.T[10], hysteresis.u) annotation (Line(
      points={{78,-27.7},{110,-27.7},{110,20},{100,20}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(emission.heatPortRad, heatPortRad) annotation (Line(
      points={{-159,-26},{-160,-26},{-160,-20},{-200,-20}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(emission.heatPortCon, heatPortCon) annotation (Line(
      points={{-155,-26},{-154,-26},{-154,20},{-200,20}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(storageTank_OneIntHX.portHXLower, pipeSupply1.port_a) annotation (
      Line(
      points={{40,-58.4615},{-4.44089e-016,-58.4615},{-4.44089e-016,-18}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipeSupply1.port_b, spl1.port_3) annotation (Line(
      points={{6.66134e-016,2},{6.66134e-016,45},{-1.33227e-015,45},{
          -1.33227e-015,70}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipeSupply1.heatPort, fixedTemperature.port) annotation (Line(
      points={{-4,-8},{-36,-8},{-36,6},{-132,6},{-132,2}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(pump.port_b, pipeSupply2.port_b) annotation (Line(
      points={{28,10},{28,-12}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipeSupply2.port_a, storageTank_OneIntHX.portHXUpper) annotation (
      Line(
      points={{28,-32},{28,-48.9231},{40,-48.9231}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipeSupply2.heatPort, fixedTemperature.port) annotation (Line(
      points={{24,-22},{-8,-22},{-8,-8},{-36,-8},{-36,6},{-132,6},{-132,2}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(absolutePressure1.ports[1], dHW_ProfileReader.port_cold) annotation (
      Line(
      points={{116,-20},{100,-20},{100,-34}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(portDhwIn, spl2.port_1) annotation (Line(
      points={{60,100},{60,90},{28,90},{28,70}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(spl2.port_3, idealCtrlMixer.port_a1) annotation (Line(
      points={{18,60},{-20,60},{-20,58},{-20,58}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(spl2.port_2, pump.port_a) annotation (Line(
      points={{28,50},{28,30}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -100},{200,100}}), graphics));
end DhwBoilerDirectSh;
