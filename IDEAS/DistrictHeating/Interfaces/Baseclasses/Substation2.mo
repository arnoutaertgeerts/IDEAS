within IDEAS.DistrictHeating.Interfaces.Baseclasses;
model Substation2
  Fluid.Interfaces.FlowPort_a flowPortSupplyIn(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Supply line in connection"
    annotation (Placement(transformation(extent={{90,10},{110,30}})));
  Fluid.Interfaces.FlowPort_a flowPortSHIn(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Cold water from the SH"
    annotation (Placement(transformation(extent={{-170,30},{-150,50}})));
  Fluid.Interfaces.FlowPort_b flowPortReturnOut(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Return line out connection"
    annotation (Placement(transformation(extent={{90,-30},{110,-10}})));
  Fluid.Interfaces.FlowPort_b flowPortSHOut(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Supply of hot water for SH"
    annotation (Placement(transformation(extent={{-170,70},{-150,90}})));
  Fluid.Interfaces.FlowPort_a flowPortDHWIn(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Return of cold water from DHW" annotation (Placement(transformation(extent
          ={{-170,-90},{-150,-70}}), iconTransformation(extent={{-170,-90},{
            -150,-70}})));
  Fluid.Interfaces.FlowPort_b flowPortDHWOut(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Supply of hot water for DHW" annotation (Placement(transformation(extent={
            {-170,-50},{-150,-30}}), iconTransformation(extent={{-170,-50},{
            -150,-30}})));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-160,
            -100},{100,100}}), graphics), Icon(coordinateSystem(extent={{-160,
            -100},{100,100}}, preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-160,100},{100,-100}},
          lineColor={182,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-15,9},{15,-1},{-15,-11},{-15,9}},
          smooth=Smooth.None,
          fillColor={255,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          pattern=LinePattern.None,
          lineColor={0,0,0},
          origin={55,19},
          rotation=180),
        Polygon(
          points={{-11,5},{9,-1},{-11,-7},{-11,5}},
          smooth=Smooth.None,
          fillColor={215,215,215},
          fillPattern=FillPattern.HorizontalCylinder,
          pattern=LinePattern.None,
          lineColor={0,0,0},
          origin={59,19},
          rotation=180),
        Line(
          points={{50,20},{100,20}},
          color={255,0,0},
          smooth=Smooth.None),
        Polygon(
          points={{-15,9},{15,-1},{-15,-11},{-15,9}},
          smooth=Smooth.None,
          fillColor={255,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          pattern=LinePattern.None,
          lineColor={0,0,0},
          origin={-135,79},
          rotation=180),
        Polygon(
          points={{-11,5},{9,-1},{-11,-7},{-11,5}},
          smooth=Smooth.None,
          fillColor={215,215,215},
          fillPattern=FillPattern.HorizontalCylinder,
          pattern=LinePattern.None,
          lineColor={0,0,0},
          origin={-131,79},
          rotation=180),
        Line(
          points={{-140,80},{-100,80}},
          color={255,0,0},
          smooth=Smooth.None),
        Polygon(
          points={{-15,9},{15,-1},{-15,-11},{-15,9}},
          smooth=Smooth.None,
          fillColor={255,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          pattern=LinePattern.None,
          lineColor={0,0,0},
          origin={-135,-41},
          rotation=180),
        Polygon(
          points={{-11,5},{9,-1},{-11,-7},{-11,5}},
          smooth=Smooth.None,
          fillColor={215,215,215},
          fillPattern=FillPattern.HorizontalCylinder,
          pattern=LinePattern.None,
          lineColor={0,0,0},
          origin={-131,-41},
          rotation=180),
        Line(
          points={{-140,-40},{-100,-40}},
          color={255,0,0},
          smooth=Smooth.None),
        Polygon(
          points={{-15,9},{15,-1},{-15,-11},{-15,9}},
          smooth=Smooth.None,
          fillColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder,
          pattern=LinePattern.None,
          lineColor={0,0,0},
          origin={-115,41},
          rotation=360),
        Polygon(
          points={{-11,5},{9,-1},{-11,-7},{-11,5}},
          smooth=Smooth.None,
          fillColor={215,215,215},
          fillPattern=FillPattern.HorizontalCylinder,
          pattern=LinePattern.None,
          lineColor={0,0,0},
          origin={-119,41},
          rotation=360),
        Line(
          points={{-20,0},{20,0}},
          color={0,0,255},
          smooth=Smooth.None,
          origin={-130,40},
          rotation=180),
        Polygon(
          points={{-15,9},{15,-1},{-15,-11},{-15,9}},
          smooth=Smooth.None,
          fillColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder,
          pattern=LinePattern.None,
          lineColor={0,0,0},
          origin={-115,-79},
          rotation=360),
        Polygon(
          points={{-11,5},{9,-1},{-11,-7},{-11,5}},
          smooth=Smooth.None,
          fillColor={215,215,215},
          fillPattern=FillPattern.HorizontalCylinder,
          pattern=LinePattern.None,
          lineColor={0,0,0},
          origin={-119,-79},
          rotation=360),
        Line(
          points={{-20,0},{20,0}},
          color={0,0,255},
          smooth=Smooth.None,
          origin={-130,-80},
          rotation=180),
        Polygon(
          points={{-15,9},{15,-1},{-15,-11},{-15,9}},
          smooth=Smooth.None,
          fillColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder,
          pattern=LinePattern.None,
          lineColor={0,0,0},
          origin={75,-19},
          rotation=360),
        Polygon(
          points={{-11,5},{9,-1},{-11,-7},{-11,5}},
          smooth=Smooth.None,
          fillColor={215,215,215},
          fillPattern=FillPattern.HorizontalCylinder,
          pattern=LinePattern.None,
          lineColor={0,0,0},
          origin={71,-19},
          rotation=360),
        Line(
          points={{-20,0},{20,3.55271e-015}},
          color={0,0,255},
          smooth=Smooth.None,
          origin={60,-20},
          rotation=180),
        Rectangle(extent={{-100,88},{40,-90}}, lineColor={95,95,95})}));
end Substation2;
