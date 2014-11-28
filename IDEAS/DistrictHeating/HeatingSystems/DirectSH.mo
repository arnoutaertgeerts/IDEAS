within IDEAS.DistrictHeating.HeatingSystems;
model DirectSH
  extends BaseClasses.PartialHeatingSystem(
    redeclare replaceable package Medium = IDEAS.Media.Water.Simple,
    redeclare Fluid.HeatExchangers.Radiators.Radiator emission(
      redeclare package Medium = Medium),
    redeclare replaceable HydraulicCircuits.Direct hydraulicCircuitSH(
      m1_flow_nominal=m_flow_nominal,
      m2_flow_nominal=m_flow_nominal,
      redeclare package Medium1 = Medium,
      redeclare package Medium2 = Medium,
      from_dp=true),
    pipeSupply(m=1, UA=10),
    pipeReturn(m=1, UA=10),
    redeclare Control.Hysteresis controlSH(
      release=false,
      uLow=273.15 + 21,
      realTrue=0,
      realFalse=1,
      uHigh=273.15 + 23));

  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow[nZones](Q_flow=0)
                                                                            annotation (
     Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-180,60})));
equation
  QHeaSys = -sum(emission.heatPortCon.Q_flow) - sum(emission.heatPortRad.Q_flow);
  P[1] = 0;
  Q[1] = 0;

  connect(port_a, zoneSplitter.port_a) annotation (Line(
      points={{-60,-100},{-60,-80},{-88,-80},{-88,0.2}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(zoneSplitter.port_b, port_b) annotation (Line(
      points={{-76,0},{-76,-72},{60,-72},{60,-100}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(fixedHeatFlow.port, heatPortEmb) annotation (Line(
      points={{-190,60},{-200,60}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(TSensor, controlSH.u) annotation (Line(
      points={{-204,-60},{-140,-60},{-140,38},{-129.2,38}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -100},{200,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-200,-100},{200,100}}), graphics));
end DirectSH;
