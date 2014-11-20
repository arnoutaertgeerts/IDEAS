within IDEAS.DistrictHeating.Pipes;
model PreinsulatedPipes
  "A symmetrical preinsulated pipe model where each pipe has its own insulation"

  //Extensions
  extends BaseClasses.DistrictHeatingPipe(
    hs=1/hsInvers,
    ha=1/haInvers);

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
            -120},{100,120}}), graphics));
end PreinsulatedPipes;
