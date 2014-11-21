within IDEAS.DistrictHeating.Interfaces;
model DHConnection

  replaceable package Medium =Modelica.Media.Interfaces.PartialMedium
    "Medium in the component"  annotation (choicesAllMatching = true);

  //Components
  IDEAS.Fluid.Interfaces.FlowPort_b flowPort_supply_out(redeclare package
      Medium = Medium) "Supply line out connection"
    annotation (Placement(transformation(extent={{-110,-50},{-90,-30}}),
        iconTransformation(extent={{-110,-50},{-90,-30}})));
  IDEAS.Fluid.Interfaces.FlowPort_a flowPort_supply_in(redeclare package Medium
      = Medium) "Supply line in connection"
    annotation (Placement(transformation(extent={{90,-50},{110,-30}}),
        iconTransformation(extent={{90,-50},{110,-30}})));
  IDEAS.Fluid.Interfaces.FlowPort_a flowPort_return_in(redeclare package Medium
      = Medium) "Return line in connection"
    annotation (Placement(transformation(extent={{-110,-90},{-90,-70}}),
        iconTransformation(extent={{-110,-90},{-90,-70}})));
  IDEAS.Fluid.Interfaces.FlowPort_b flowPort_return_out(redeclare package
      Medium = Medium) "Return line out connection"
    annotation (Placement(transformation(extent={{90,-90},{110,-70}}),
        iconTransformation(extent={{90,-90},{110,-70}})));

  replaceable Pipes.BaseClasses.DistrictHeatingPipe districtHeatingPipe(
      redeclare package Medium1 = Medium, redeclare package Medium2 = Medium)
    annotation (Placement(transformation(extent={{48,-68},{28,-40}})), choicesAllMatching=true);
  Modelica.Fluid.Sensors.TemperatureTwoPort Tsupply(redeclare package Medium =
        Medium) "Sensor of the return temperature"
                                       annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-40,-40})));
  Modelica.Fluid.Sensors.TemperatureTwoPort TReturn(redeclare package Medium =
        Medium) "Sensor of the return temperature"
                                       annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-40,-80})));
  IDEAS.Fluid.Interfaces.FlowPort_a flowPortIn(redeclare package Medium =
        Medium) "Return line from the building"
    annotation (Placement(transformation(extent={{-30,10},{-10,30}})));
  IDEAS.Fluid.Interfaces.FlowPort_b flowPortOut(redeclare package Medium =
        Medium) "Supply line to the building"
    annotation (Placement(transformation(extent={{10,10},{30,30}})));
  Modelica.Blocks.Interfaces.RealInput TAmbient
    "Outside air or ground temperature" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-20,-150}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-20,-150})));
  Fluid.FixedResistances.SplitterFixedResistanceDpM       spl2(
    redeclare package Medium =
        Medium,
    m_flow_nominal={0.25,-0.25,-0.25},
    dp_nominal={20,-20,-20}) "Splitter for bypass"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={0,-40})));
  Fluid.FixedResistances.SplitterFixedResistanceDpM       spl1(
    redeclare package Medium =
        Medium,
    m_flow_nominal={0.25,-0.25,-0.25},
    dp_nominal={20,-20,-20}) "Splitter for bypass"
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-10,-80})));
equation
  connect(Tsupply.port_b, flowPort_supply_out) annotation (Line(
      points={{-50,-40},{-100,-40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(flowPort_return_in, TReturn.port_a) annotation (Line(
      points={{-100,-80},{-50,-80}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(TAmbient, districtHeatingPipe.Tg) annotation (Line(
      points={{-20,-150},{-20,-100},{38,-100},{38,-68.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(spl2.port_2, Tsupply.port_a) annotation (Line(
      points={{-10,-40},{-30,-40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(flowPortOut, spl2.port_3) annotation (Line(
      points={{20,20},{20,-16},{0,-16},{0,-30}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(TReturn.port_b, spl1.port_1) annotation (Line(
      points={{-30,-80},{-20,-80}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(flowPortIn, spl1.port_3) annotation (Line(
      points={{-20,20},{-20,-60},{-10,-60},{-10,-70}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(districtHeatingPipe.port_b1, spl2.port_1) annotation (Line(
      points={{28,-48},{16,-48},{16,-40},{10,-40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(districtHeatingPipe.port_a1, flowPort_supply_in) annotation (Line(
      points={{48,-48},{60,-48},{60,-40},{100,-40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(spl1.port_2, districtHeatingPipe.port_a2) annotation (Line(
      points={{0,-80},{20,-80},{20,-60},{28,-60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(districtHeatingPipe.port_b2, flowPort_return_out) annotation (Line(
      points={{48,-60},{60,-60},{60,-80},{100,-80}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -140},{100,20}}),  graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-140},{100,20}}),
                                               graphics={
        Polygon(
          points={{15,11},{-15,1},{15,-11},{15,11}},
          smooth=Smooth.None,
          fillColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder,
          pattern=LinePattern.None,
          lineColor={0,0,0},
          origin={-19,-65},
          rotation=90),
        Polygon(
          points={{15,11},{-15,1},{15,-11},{15,11}},
          smooth=Smooth.None,
          fillColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder,
          pattern=LinePattern.None,
          lineColor={0,0,0},
          origin={75,-79},
          rotation=180),
        Polygon(
          points={{11,7},{-11,1},{11,-7},{11,7}},
          smooth=Smooth.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.HorizontalCylinder,
          pattern=LinePattern.None,
          lineColor={0,0,0},
          origin={-19,-61},
          rotation=90),
        Polygon(
          points={{-15,9},{15,-1},{-15,-11},{-15,9}},
          smooth=Smooth.None,
          fillColor={255,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          pattern=LinePattern.None,
          lineColor={0,0,0},
          origin={-75,-41},
          rotation=180),
        Polygon(
          points={{-11,5},{9,-1},{-11,-7},{-11,5}},
          smooth=Smooth.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.HorizontalCylinder,
          pattern=LinePattern.None,
          lineColor={0,0,0},
          origin={-71,-41},
          rotation=180),
        Line(
          points={{-92,-40},{92,-40}},
          color={255,0,0},
          smooth=Smooth.None),
        Polygon(
          points={{-15,9},{15,-1},{-15,-11},{-15,9}},
          smooth=Smooth.None,
          fillColor={255,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          pattern=LinePattern.None,
          lineColor={0,0,0},
          origin={19,-5},
          rotation=90),
        Polygon(
          points={{-11,5},{9,-1},{-11,-7},{-11,5}},
          smooth=Smooth.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.HorizontalCylinder,
          pattern=LinePattern.None,
          lineColor={0,0,0},
          origin={19,-9},
          rotation=90),
        Line(
          points={{20,0},{20,-40}},
          color={255,0,0},
          smooth=Smooth.None),
        Polygon(
          points={{11,7},{-11,1},{11,-7},{11,7}},
          smooth=Smooth.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.HorizontalCylinder,
          pattern=LinePattern.None,
          lineColor={0,0,0},
          origin={71,-79},
          rotation=180),
        Line(
          points={{-20,10},{-20,-72}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{92,-80},{-92,-80}},
          color={0,0,255},
          smooth=Smooth.None),
        Ellipse(
          extent={{18,-38},{22,-42}},
          lineColor={255,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-22,-78},{-18,-82}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{40,-30},{80,-50}},
          lineColor={255,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{0,-68},{40,-88}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder)}));

end DHConnection;
