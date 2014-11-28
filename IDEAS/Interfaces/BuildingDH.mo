within IDEAS.Interfaces;
model BuildingDH

  outer Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{-80,80},{-60,100}})));
  outer IDEAS.SimInfoManager sim
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  parameter Boolean standAlone=true;

  replaceable IDEAS.Interfaces.BaseClasses.Structure building
    "Building structure" annotation (Placement(transformation(extent={{-64,18},{
            -34,38}})),  choicesAllMatching=true);
  replaceable BaseClasses.HeatingSystemDH heatingSystem(
    nZones=building.nZones)
      constrainedby IDEAS.Interfaces.BaseClasses.HeatingSystemDH(
        nZones=building.nZones) "Thermal building heating system"
                                      annotation (Placement(transformation(
          extent={{-14,18},{26,38}})),  choicesAllMatching=true);
  replaceable IDEAS.Interfaces.BaseClasses.Occupant occupant(nZones=building.nZones)
    constrainedby IDEAS.Interfaces.BaseClasses.Occupant(nZones=building.nZones)
    "Building occupant" annotation (Placement(transformation(extent={{-18,-40},{
            20,-20}})),  choicesAllMatching=true);
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
      points={{-34,30},{-26,30},{-26,-28},{-18,-28}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(building.heatPortRad, occupant.heatPortRad) annotation (Line(
      points={{-34,26},{-28,26},{-28,-32},{-18,-32}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(building.TSensor, heatingSystem.TSensor) annotation (Line(
      points={{-33.4,22},{-14.4,22}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(building.TSensor, ventilationSystem.TSensor) annotation (Line(
      points={{-33.4,22},{-28,22},{-28,70},{-20.4,70}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(ventilationSystem.plugLoad, inHomeGrid.nodeSingle) annotation (Line(
      points={{20,76},{32,76},{32,24},{52,24}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(heatingSystem.plugLoad, inHomeGrid.nodeSingle) annotation (Line(
      points={{26,28},{38,28},{38,24},{52,24}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(occupant.plugLoad, inHomeGrid.nodeSingle) annotation (Line(
      points={{20,-30},{32,-30},{32,24},{52,24}},
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
      points={{-34,34},{-14,34}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(building.heatPortCon, heatingSystem.heatPortCon) annotation (Line(
      points={{-34,30},{-14,30}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(building.heatPortRad, heatingSystem.heatPortRad) annotation (Line(
      points={{-34,26},{-14,26}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(building.flowPort_Out, ventilationSystem.flowPort_In) annotation (
      Line(
      points={{-51,38},{-52,38},{-52,78},{-20,78}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(building.flowPort_In, ventilationSystem.flowPort_Out) annotation (
      Line(
      points={{-47,38},{-48,38},{-48,74},{-20,74}},
      color={0,0,0},
      smooth=Smooth.None));

  connect(heatingSystem.TSet, occupant.TSet) annotation (Line(
      points={{-8,18},{-8,0},{2,0},{2,-20},{1,-20}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(heatingSystem.mDHW60C, occupant.mDHW60C) annotation (Line(
      points={{16,17.8},{16,0},{8,0},{8,-20},{6.7,-20}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(heatingSystem.port_a, flowPortSupplyIn) annotation (Line(
      points={{0,18},{0,-8},{-38,-8},{-38,-60},{20,-60},{20,-98}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(heatingSystem.port_b, flowPortReturnOut) annotation (Line(
      points={{12,18},{12,-4},{-44,-4},{-44,-74},{-20,-74},{-20,-98}},
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
