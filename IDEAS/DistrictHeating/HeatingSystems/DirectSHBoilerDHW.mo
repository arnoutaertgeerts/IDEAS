within IDEAS.DistrictHeating.HeatingSystems;
model DirectSHBoilerDHW
  //Extensions
  extends BaseClasses.PartialHeatingSystem(
                                  redeclare HydraulicCircuits.Direct
      hydraulicCircuitPartial, redeclare replaceable HydraulicCircuits.Direct
      hydraulicCircuitDHW(
      hysteresis(uLow=65, uHigh=55),
      redeclare package Medium1 = Medium,
      redeclare package Medium2 = Medium,
      m1_flow_nominal=0.1,
      m2_flow_nominal=0.1),
    redeclare HydraulicCircuits.Direct hydraulicCircuitSH);

  Fluid.Storage.StorageTank_OneIntHX storageTank_OneIntHX
    annotation (Placement(transformation(extent={{20,0},{54,48}})));
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
        origin={86,20})));
  replaceable HydraulicCircuits.Direct direct annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={10,-32})));
equation
  connect(port_a, zoneSplitter.port_a) annotation (Line(
      points={{-60,-100},{-60,-80},{-88,-80},{-88,-35.8}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(port_b, zoneSplitter.port_b) annotation (Line(
      points={{60,-100},{60,-60},{-76,-60},{-76,-36}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(storageTank_OneIntHX.port_a, dHW.port_cold) annotation (Line(
      points={{54,44.3077},{84,44.3077},{84,34},{84.3333,34},{84.3333,35.0952}},
      color={0,127,255},
      smooth=Smooth.None));

  connect(storageTank_OneIntHX.port_b, dHW.port_hot) annotation (Line(
      points={{54,3.69231},{84.3333,3.69231},{84.3333,15.0952}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(TSensor, hydraulicCircuitSH.TSensor) annotation (Line(
      points={{-204,-60},{-124,-60},{-124,8},{-93.4,8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(storageTank_OneIntHX.T[5], hydraulicCircuitDHW.TSensor) annotation (
      Line(
      points={{54,29.3538},{60,29.3538},{60,60},{-14,60},{-14,-32},{-1.4,-32}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(direct.port_b1, storageTank_OneIntHX.portHXUpper) annotation (Line(
      points={{4,-22},{4,14.7692},{20,14.7692}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(direct.port_a2, storageTank_OneIntHX.portHXLower) annotation (Line(
      points={{16,-22},{16,7.38462},{20,7.38462}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(direct.port_a1, zoneSplitter.port_a) annotation (Line(
      points={{4,-42},{4,-80},{-88,-80},{-88,-35.8}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(direct.port_b2, zoneSplitter.port_b) annotation (Line(
      points={{16,-42},{16,-60},{-76,-60},{-76,-36}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -100},{200,100}}), graphics));
end DirectSHBoilerDHW;
