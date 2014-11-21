within IDEAS.DistrictHeating.Pipes;
package DoublePipes
  model PreinsulatedPipes
    "A symmetrical preinsulated pipe model where each pipe has its own insulation"

    //Extensions
    extends BaseClasses.DistrictHeatingPipe(
      hs=1/hsInvers,
      ha=1/haInvers,
      Do=0.25);

    //Parameters
  protected
    parameter Real hsInvers=
      Modelica.Math.log(2*Heff/ro) + beta +
      Modelica.Math.log(sqrt(1 + (Heff/D)^2));
    parameter Real haInvers=
      Modelica.Math.log(2*Heff/ro) + beta -
      Modelica.Math.log(sqrt(1 + (Heff/D)^2));

  equation
    Qs=(Ts-Tg)*2*Modelica.Constants.pi*lambdaG*hs;
    Qa=Ta*2*Modelica.Constants.pi*lambdaG*ha;

    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -120},{100,120}}), graphics), Icon(coordinateSystem(
            preserveAspectRatio=false, extent={{-100,-140},{100,140}}), graphics={
          Ellipse(
            extent={{-40,-20},{40,-100}},
            lineColor={135,135,135},
            fillPattern=FillPattern.Forward,
            fillColor={255,255,255},
            startAngle=0,
            endAngle=360),
          Ellipse(
            extent={{-40,100},{40,20}},
            lineColor={135,135,135},
            fillPattern=FillPattern.Forward,
            fillColor={255,255,255},
            startAngle=0,
            endAngle=360),
          Ellipse(
            extent={{30,30},{-30,90}},
            lineColor={255,0,0},
            fillColor={255,0,0},
            fillPattern=FillPattern.Sphere),
          Ellipse(
            extent={{30,-90},{-30,-30}},
            lineColor={0,0,255},
            fillColor={0,0,255},
            fillPattern=FillPattern.Sphere),
          Rectangle(
            extent={{-100,-140},{100,-114}},
            lineColor={127,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Backward),
          Line(
            points={{-100,-114},{-100,-140},{-100,-114},{100,-114},{100,-140}},
            color={255,255,255},
            smooth=Smooth.None)}));
  end PreinsulatedPipes;

  model TwinPipeGround "Twin pipe model for symmetric pipes in the ground"

    //Extensions
    extends BaseClasses.DistrictHeatingPipe(
      hs=1/hsInvers,
      ha=1/haInvers);

    //Parameters
    parameter Modelica.SIunits.Length Dc=1
      "Outer diameter of the larger circumscribing pipe";
  protected
    parameter Modelica.SIunits.Length rc=Dc/2
      "Outer radius of the larger circumscribing pipe";

  protected
    parameter Real hsInvers=
      2*lambdaI/lambdaG*Modelica.Math.log(2*Heff/rc) +
      Modelica.Math.log(rc^2/(2*D*ri)) +
      sigma*Modelica.Math.log(rc^4/(rc^4-D^4));
    parameter Real haInvers=
      Modelica.Math.log(2*D/ri) +
      sigma*Modelica.Math.log((rc^2+D^2)/(rc^2-D^2));
    parameter Real sigma = (lambdaI-lambdaG)/(lambdaI+lambdaG);

  equation
    Qs=(Ts-Tg)*2*Modelica.Constants.pi*lambdaI*hs;
    Qa=Ta*2*Modelica.Constants.pi*lambdaI*ha;
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-140},
              {100,140}}),
                     graphics={
          Ellipse(
            extent={{100,-100},{-100,100}},
            lineColor={135,135,135},
            fillColor={255,255,255},
            fillPattern=FillPattern.Forward),
          Polygon(
            points={{34,24},{64,14},{34,2},{34,24}},
            smooth=Smooth.None,
            fillColor={255,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            pattern=LinePattern.None,
            lineColor={0,0,0}),
          Ellipse(
            extent={{30,-90},{-30,-30}},
            lineColor={0,0,255},
            fillColor={0,0,255},
            fillPattern=FillPattern.Sphere),
          Polygon(
            points={{34,20},{56,14},{34,6},{34,20}},
            smooth=Smooth.None,
            fillColor={255,255,255},
            fillPattern=FillPattern.HorizontalCylinder,
            pattern=LinePattern.None,
            lineColor={0,0,0}),
          Line(
            points={{-58,14},{58,14}},
            color={255,0,0},
            smooth=Smooth.None),
          Polygon(
            points={{-32,0},{-62,-10},{-32,-22},{-32,0}},
            smooth=Smooth.None,
            fillColor={0,0,255},
            fillPattern=FillPattern.HorizontalCylinder,
            pattern=LinePattern.None,
            lineColor={0,0,0}),
          Polygon(
            points={{-32,-4},{-54,-10},{-32,-18},{-32,-4}},
            smooth=Smooth.None,
            fillColor={255,255,255},
            fillPattern=FillPattern.HorizontalCylinder,
            pattern=LinePattern.None,
            lineColor={0,0,0}),
          Line(
            points={{60,-10},{-52,-10}},
            color={0,0,255},
            smooth=Smooth.None),
          Ellipse(
            extent={{30,28},{-30,88}},
            lineColor={255,0,0},
            fillColor={255,0,0},
            fillPattern=FillPattern.Sphere),
          Rectangle(
            extent={{-100,-140},{100,-114}},
            lineColor={127,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Backward),
          Line(
            points={{-100,-114},{-100,-140},{-100,-114},{100,-114},{100,-140}},
            color={255,255,255},
            smooth=Smooth.None)}));
  end TwinPipeGround;

  model TwinPipeAir "Twin pipe model for symmetric pipes above the ground"

    //Extensions
    extends BaseClasses.DistrictHeatingPipe(
      hs=1/hsInvers,
      ha=1/haInvers);

    //Parameters
    parameter Modelica.SIunits.Length Dc
      "Outer diameter of the larger circumscribing pipe";
  protected
    parameter Modelica.SIunits.Length rc=Dc/2
      "Outer radius of the larger circumscribing pipe";

  protected
    parameter Real hsInvers=
      Modelica.Math.log(rc^2/(2*D*ri)) -
      Modelica.Math.log(rc^4/(rc^4-D^4));
    parameter Real haInvers=
      Modelica.Math.log(2*D/ri) -
      Modelica.Math.log((rc^2+D^2)/(rc^2-D^2));

  equation
    Qs=(Ts-Tg)*2*Modelica.Constants.pi*lambdaI*hs;
    Qa=Ta*2*Modelica.Constants.pi*lambdaI*ha;
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-140},
              {100,140}}),
                     graphics={
          Ellipse(
            extent={{100,-100},{-100,100}},
            lineColor={135,135,135},
            fillColor={255,255,255},
            fillPattern=FillPattern.Forward),
          Polygon(
            points={{34,24},{64,14},{34,2},{34,24}},
            smooth=Smooth.None,
            fillColor={255,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            pattern=LinePattern.None,
            lineColor={0,0,0}),
          Ellipse(
            extent={{30,-90},{-30,-30}},
            lineColor={0,0,255},
            fillColor={0,0,255},
            fillPattern=FillPattern.Sphere),
          Polygon(
            points={{34,20},{56,14},{34,6},{34,20}},
            smooth=Smooth.None,
            fillColor={255,255,255},
            fillPattern=FillPattern.HorizontalCylinder,
            pattern=LinePattern.None,
            lineColor={0,0,0}),
          Line(
            points={{-58,14},{58,14}},
            color={255,0,0},
            smooth=Smooth.None),
          Polygon(
            points={{-32,0},{-62,-10},{-32,-22},{-32,0}},
            smooth=Smooth.None,
            fillColor={0,0,255},
            fillPattern=FillPattern.HorizontalCylinder,
            pattern=LinePattern.None,
            lineColor={0,0,0}),
          Polygon(
            points={{-32,-4},{-54,-10},{-32,-18},{-32,-4}},
            smooth=Smooth.None,
            fillColor={255,255,255},
            fillPattern=FillPattern.HorizontalCylinder,
            pattern=LinePattern.None,
            lineColor={0,0,0}),
          Line(
            points={{60,-10},{-52,-10}},
            color={0,0,255},
            smooth=Smooth.None),
          Ellipse(
            extent={{30,28},{-30,88}},
            lineColor={255,0,0},
            fillColor={255,0,0},
            fillPattern=FillPattern.Sphere),
          Rectangle(
            extent={{-100,-140},{100,-114}},
            lineColor={85,170,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Backward),
          Line(
            points={{-100,-114},{-100,-140},{-100,-114},{100,-114},{100,-140}},
            color={255,255,255},
            smooth=Smooth.None)}));
  end TwinPipeAir;
end DoublePipes;
