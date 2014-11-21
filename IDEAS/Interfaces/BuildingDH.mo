within IDEAS.Interfaces;
model BuildingDH

  outer Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{-80,80},{-60,100}})));
  outer IDEAS.SimInfoManager sim
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  parameter Boolean standAlone=true;
  parameter Boolean DH=false
    "true/false if building is/is not in district heating network";

  parameter Integer numberOfConnections=1 if DH
    "Number of connections to the DH substation";
  replaceable IDEAS.Interfaces.BaseClasses.Structure building
    "Building structure" annotation (Placement(transformation(extent={{-64,6},{
            -34,26}})),  choicesAllMatching=true);
  replaceable IDEAS.Interfaces.BaseClasses.HeatingSystem heatingSystem(
    nZones=building.nZones,
    DH=DH,
    numberOfConnections=numberOfConnections) "Thermal building heating system"
                                      annotation (Placement(transformation(
          extent={{-16,6},{24,26}})),   choicesAllMatching=true);
  replaceable IDEAS.Interfaces.BaseClasses.Occupant occupant(nZones=building.nZones)
    constrainedby IDEAS.Interfaces.BaseClasses.Occupant(nZones=building.nZones)
    "Building occupant" annotation (Placement(transformation(extent={{-16,-26},
            {22,-6}})),  choicesAllMatching=true);
  replaceable IDEAS.Interfaces.BaseClasses.CausalInhomeFeeder inHomeGrid
    constrainedby IDEAS.Interfaces.BaseClasses.CausalInhomeFeeder
    "Inhome low-voltage electricity grid system" annotation (Placement(
        transformation(extent={{52,14},{72,34}})),  __Dymola_choicesAllMatching=
       true);

  replaceable IDEAS.Interfaces.BaseClasses.VentilationSystem ventilationSystem(
      nZones=building.nZones, VZones=building.VZones) "Ventilation system"
    annotation (Placement(transformation(extent={{-20,66},{20,86}})),
      choicesAllMatching=true);
  Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin
    plugFeeder(v(re(start=230), im(start=0))) if not standAlone
    "Electricity connection to the district feeder"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VoltageSource
    voltageSource(
    f=50,
    V=230,
    phi=0) if standAlone annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={70,-30})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground ground if
    standAlone
    annotation (Placement(transformation(extent={{60,-80},{80,-60}})));

  Fluid.Interfaces.FlowPort_a flowPortSupplyIn(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Supply line in connection"
    annotation (Placement(transformation(extent={{10,-108},{30,-88}})));
  Fluid.Interfaces.FlowPort_b flowPortReturnOut(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Return line out connection"
    annotation (Placement(transformation(extent={{-30,-108},{-10,-88}})));
equation
  connect(building.heatPortCon, occupant.heatPortCon) annotation (Line(
      points={{-34,18},{-26,18},{-26,-14},{-16,-14}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(building.heatPortRad, occupant.heatPortRad) annotation (Line(
      points={{-34,14},{-28,14},{-28,-18},{-16,-18}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(building.TSensor, heatingSystem.TSensor) annotation (Line(
      points={{-33.4,10},{-16.4,10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(building.TSensor, ventilationSystem.TSensor) annotation (Line(
      points={{-33.4,10},{-28,10},{-28,70},{-20.4,70}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(ventilationSystem.plugLoad, inHomeGrid.nodeSingle) annotation (Line(
      points={{20,76},{32,76},{32,24},{52,24}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(heatingSystem.plugLoad, inHomeGrid.nodeSingle) annotation (Line(
      points={{24,16},{38,16},{38,24},{52,24}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(occupant.plugLoad, inHomeGrid.nodeSingle) annotation (Line(
      points={{22,-16},{32,-16},{32,24},{52,24}},
      color={85,170,255},
      smooth=Smooth.None));

  if standAlone then
    connect(voltageSource.pin_p, ground.pin) annotation (Line(
        points={{70,-40},{70,-60}},
        color={85,170,255},
        smooth=Smooth.None));
    connect(inHomeGrid.pinSingle, voltageSource.pin_n) annotation (Line(
        points={{72,24},{70,24},{70,-20}},
        color={85,170,255},
        smooth=Smooth.None));
  else
    connect(inHomeGrid.pinSingle, plugFeeder) annotation (Line(
        points={{72,24},{84,24},{84,0},{100,0}},
        color={85,170,255},
        smooth=Smooth.None));
  end if;


  connect(building.heatPortEmb, heatingSystem.heatPortEmb) annotation (Line(
      points={{-34,22},{-16,22}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(building.heatPortCon, heatingSystem.heatPortCon) annotation (Line(
      points={{-34,18},{-16,18}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(building.heatPortRad, heatingSystem.heatPortRad) annotation (Line(
      points={{-34,14},{-16,14}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(building.flowPort_Out, ventilationSystem.flowPort_In) annotation (
      Line(
      points={{-51,26},{-52,26},{-52,78},{-20,78}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(building.flowPort_In, ventilationSystem.flowPort_Out) annotation (
      Line(
      points={{-47,26},{-48,26},{-48,74},{-20,74}},
      color={0,0,0},
      smooth=Smooth.None));

  connect(heatingSystem.TSet, occupant.TSet) annotation (Line(
      points={{4,5.8},{4,-6},{3,-6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(heatingSystem.mDHW60C, occupant.mDHW60C) annotation (Line(
      points={{10,5.8},{10,-6},{8.7,-6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(heatingSystem.portSupplyIn, flowPortSupplyIn) annotation (Line(
      points={{10,26},{10,42},{-72,42},{-72,-60},{20,-60},{20,-98}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(heatingSystem.portReturnOut, flowPortReturnOut) annotation (Line(
      points={{6,26},{6,38},{-78,38},{-78,-66},{-20,-66},{-20,-98}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}),
                   graphics={
        Line(
          points={{60,22},{0,74},{-60,24},{-60,-46},{60,-46}},
          color={127,0,0},
          smooth=Smooth.None),
        Polygon(
          points={{60,22},{56,18},{0,64},{-54,20},{-54,-40},{60,-40},{60,-46},{
              -60,-46},{-60,24},{0,74},{60,22}},
          lineColor={127,0,0},
          smooth=Smooth.None,
          fillColor={127,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-46,6},{-46,-6},{-44,-8},{-24,4},{-24,16},{-26,18},{-46,6}},
          lineColor={127,0,0},
          smooth=Smooth.None,
          fillColor={127,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-46,-18},{-46,-30},{-44,-32},{-24,-20},{-24,-8},{-26,-6},{-46,
              -18}},
          lineColor={127,0,0},
          smooth=Smooth.None,
          fillColor={127,0,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-44,-4},{-50,-8},{-50,-32},{-46,-36},{28,-36},{42,-26}},
          color={127,0,0},
          smooth=Smooth.None),
        Line(
          points={{-50,-32},{-44,-28}},
          color={127,0,0},
          smooth=Smooth.None),
        Line(
          points={{-24,14},{-20,16},{-20,-18},{-16,-22},{-16,-22},{40,-22}},
          color={127,0,0},
          smooth=Smooth.None),
        Line(
          points={{-24,-10},{-20,-8}},
          color={127,0,0},
          smooth=Smooth.None),
        Polygon(
          points={{40,-12},{40,-32},{50,-38},{58,-32},{58,-16},{54,-10},{48,-6},
              {40,-12}},
          lineColor={127,0,0},
          smooth=Smooth.None,
          fillColor={127,0,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-98,-46},{102,-86}},
          lineColor={127,0,0},
          textString="%name")}), Diagram(coordinateSystem(preserveAspectRatio=false,
                   extent={{-100,-100},{100,100}}), graphics));
end BuildingDH;
