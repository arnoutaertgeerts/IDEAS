within IDEAS.DistrictHeating.Pipes;
model TwinPipeGround "Twin pipe model for symmetric pipes"

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
  annotation (Icon(graphics={
        Rectangle(
          extent={{-100,18},{100,-18}},
          lineColor={175,175,175},
          fillColor={255,255,255},
          fillPattern=FillPattern.Backward)}));
end TwinPipeGround;
