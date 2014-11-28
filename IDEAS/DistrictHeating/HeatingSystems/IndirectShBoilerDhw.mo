within IDEAS.DistrictHeating.HeatingSystems;
model IndirectSHBoilerDHW
  //Extensions
  extends IndirectSH(
    redeclare replaceable HydraulicCircuits.Mixer hydraulicCircuitPartial(
      redeclare package Medium1 = Medium,
      redeclare package Medium2 = Medium,
      m1_flow_nominal=m_flow_zone,
      m2_flow_nominal=m_flow_zone),
    redeclare Fluid.HeatExchangers.Radiators.Radiator emission,
    pipeSupply(m=1, UA=10),
    pipeReturn(m=1, UA=10),
    redeclare HydraulicCircuits.SinglePump hydraulicCircuitDHW,
    redeclare HydraulicCircuits.Mixer hydraulicCircuitSH);

  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow[nZones](Q_flow=0)
                                                                            annotation (
     Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-170,80})));
  Fluid.Storage.StorageTank_OneIntHX storageTank_OneIntHX
    annotation (Placement(transformation(extent={{28,-12},{62,36}})));
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
        origin={98,2})));
  HydraulicCircuits.SinglePump direct annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={10,-32})));
  Control.Hysteresis hysteresis1
    annotation (Placement(transformation(extent={{-32,-42},{-12,-22}})));
equation
  connect(fixedHeatFlow.port, heatPortEmb) annotation (Line(
      points={{-180,80},{-186,80},{-186,60},{-200,60}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(storageTank_OneIntHX.port_a, dHW.port_cold) annotation (Line(
      points={{62,32.3077},{96,32.3077},{96,32},{96,32},{96.3333,32},{96.3333,
          17.0952},{96.3333,17.0952}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(storageTank_OneIntHX.port_b, dHW.port_hot) annotation (Line(
      points={{62,-8.30769},{96.3333,-8.30769},{96.3333,-2.90476}},
      color={0,127,255},
      smooth=Smooth.None));

  connect(direct.port_b1, storageTank_OneIntHX.portHXUpper) annotation (Line(
      points={{4,-22},{4,2.76923},{28,2.76923}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(direct.port_a2, storageTank_OneIntHX.portHXLower) annotation (Line(
      points={{16,-22},{16,-4.61538},{28,-4.61538}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(direct.port_a1, hydraulicCircuitPartial.port_b1) annotation (Line(
      points={{4,-42},{4,-46},{-66,-46},{-66,-52},{-60,-52},{-60,-62}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(direct.port_b2, hex.port_b2) annotation (Line(
      points={{16,-42},{16,-52},{-48,-52},{-48,-38},{-72,-38},{-72,-32}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(direct.u, hysteresis1.y) annotation (Line(
      points={{-1.4,-32},{-11.2,-32}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(storageTank_OneIntHX.T[5], hysteresis1.u) annotation (Line(
      points={{62,17.3538},{66,17.3538},{66,46},{-40,46},{-40,-32},{-33.2,-32}},

      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -100},{200,100}}), graphics));
end IndirectSHBoilerDHW;
