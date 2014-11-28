within IDEAS.DistrictHeating.Interfaces;
model DHConnection

  //Packages
  replaceable package Medium =Modelica.Media.Interfaces.PartialMedium
    "Medium in the component"  annotation (choicesAllMatching = true);

  //Parameters
  parameter Boolean from_dp=false;
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal;

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
    annotation (Placement(transformation(extent={{48,-74},{28,-46}})), choicesAllMatching=true);
  IDEAS.Fluid.Interfaces.FlowPort_a flowPortIn(redeclare package Medium =
        Medium) "Return line from the building"
    annotation (Placement(transformation(extent={{-30,10},{-10,30}})));
  IDEAS.Fluid.Interfaces.FlowPort_b flowPortOut(redeclare package Medium =
        Medium) "Supply line to the building"
    annotation (Placement(transformation(extent={{10,10},{30,30}})));

  Fluid.FixedResistances.SplitterFixedResistanceDpM spl9(
    redeclare package Medium = Medium,
    dp_nominal={0,0,0},
    m_flow_nominal={m_flow_nominal,-m_flow_nominal,-m_flow_nominal})
                        annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={0,-40})));
  Fluid.FixedResistances.SplitterFixedResistanceDpM spl10(
    from_dp=false,
    redeclare package Medium = Medium,
    dp_nominal={0,0,0},
    m_flow_nominal={m_flow_nominal,-m_flow_nominal,m_flow_nominal})
                        annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-20,-80})));

  Modelica.Blocks.Sources.RealExpression realExpression(y=sim.Tground)
    annotation (Placement(transformation(extent={{6,-116},{26,-96}})));
  outer SimInfoManager sim
    annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort Tsupply(redeclare package Medium =
        Medium) "Sensor of the return temperature"
                                       annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={20,-4})));
  Modelica.Fluid.Sensors.TemperatureTwoPort TReturn(redeclare package Medium =
        Medium) "Sensor of the return temperature"
                                        annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={-20,-18})));
equation
  connect(districtHeatingPipe.port_a1, flowPort_supply_in) annotation (Line(
      points={{48,-54},{60,-54},{60,-40},{100,-40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(spl9.port_1, districtHeatingPipe.port_b1) annotation (Line(
      points={{10,-40},{16,-40},{16,-54},{28,-54}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(spl10.port_2, districtHeatingPipe.port_a2) annotation (Line(
      points={{-10,-80},{16,-80},{16,-66},{28,-66}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(flowPort_return_in, spl10.port_1) annotation (Line(
      points={{-100,-80},{-30,-80}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(realExpression.y, districtHeatingPipe.Tg) annotation (Line(
      points={{27,-106},{38,-106},{38,-74.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(flowPortOut, Tsupply.port_b) annotation (Line(
      points={{20,20},{20,6}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(Tsupply.port_a, spl9.port_3) annotation (Line(
      points={{20,-14},{20,-20},{1.33227e-015,-20},{1.33227e-015,-30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(spl10.port_3, TReturn.port_b) annotation (Line(
      points={{-20,-70},{-20,-28}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(TReturn.port_a, flowPortIn) annotation (Line(
      points={{-20,-8},{-20,20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(spl9.port_2, flowPort_supply_out) annotation (Line(
      points={{-10,-40},{-100,-40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(districtHeatingPipe.port_b2, flowPort_return_out) annotation (Line(
      points={{48,-66},{60,-66},{60,-80},{100,-80}},
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
