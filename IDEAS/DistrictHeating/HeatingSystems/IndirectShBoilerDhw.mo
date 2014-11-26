within IDEAS.DistrictHeating.HeatingSystems;
model IndirectShBoilerDhw "Indirect connection for SH and a boiler for DHW"
  extends IDEAS.DistrictHeating.HeatingSystems.PartialHydraulicHeatingDH(
    final isHea=true,
    final isCoo=false,
    final nConvPorts=nZones,
    final nRadPorts=nZones,
    final nTemSen=nZones,
    final nEmbPorts=nZones,
    nLoads=1,
    nZones=1,
    minSup=true,
    TSupMin=273.15+30,
    redeclare Fluid.HeatExchangers.Radiators.Radiator emission[nZones](
      each TInNom=TSupNom,
      each TOutNom=TSupNom - dTSupRetNom,
      TZoneNom=TRoomNom,
      QNom=QNom,
      each powerFactor=3.37,
    redeclare each package Medium = Medium),
    pumpRad(each filteredMassFlowRate=true));

  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow[nZones] fixedHeatFlow(Q_flow=0)
    annotation (Placement(transformation(extent={{-180,56},{-190,66}})));
  Fluid.Sources.FixedBoundary absolutePressure1(
    redeclare package Medium = Medium,
    use_T=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-42})));
  Fluid.Valves.Thermostatic3WayValve idealCtrlMixer(
    redeclare package Medium = Medium, m_flow_nominal=sum(m_flow_nominal))
                                   annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={-20,46})));
  Fluid.Storage.StorageTank_OneIntHX storageTank_OneIntHX
    annotation (Placement(transformation(extent={{60,-20},{78,6}})));
equation
  QHeaSys = -sum(emission.heatPortCon.Q_flow) - sum(emission.heatPortRad.Q_flow);

  P[1] = 0;
  Q[1] = 0;

  connect(emission.heatPortRad, heatPortRad) annotation (Line(
      points={{-159,-26},{-160,-26},{-160,-20},{-200,-20}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(emission.heatPortCon, heatPortCon) annotation (Line(
      points={{-155,-26},{-154,-26},{-154,20},{-200,20}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(heatPortEmb, fixedHeatFlow.port) annotation (Line(
      points={{-200,60},{-196,60},{-196,61},{-190,61},{-190,61}},
      color={191,0,0},
      smooth=Smooth.None));

  connect(absolutePressure1.ports[1], senTemEm_in.port_a) annotation (Line(
      points={{8.88178e-016,-32},{8.88178e-016,-20},{-20,-20},{-20,-36},{-26,-36}},
      color={0,127,255},
      smooth=Smooth.None));

  connect(spl.port_3, idealCtrlMixer.port_a2) annotation (Line(
      points={{-110,70},{-110,46},{-30,46}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(idealCtrlMixer.port_b, pipeSupply.port_a) annotation (Line(
      points={{-20,36},{-20,16}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(heatingCurve.TSup, idealCtrlMixer.TMixedSet) annotation (Line(
      points={{-103,28},{-4,28},{-4,46},{-10,46}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -100},{200,100}}), graphics));
end IndirectShBoilerDhw;
