within IDEAS.DistrictHeating.Pipes;
model PreinsulatedPipes
  "A symmetrical preinsulated pipe model where each pipe has its own insulation"

  //Extensions
  extends BaseClasses.DistrictHeatingPipe(
  U1 = (Rg+Ri)/((Rg+Ri)^2-Rm^2),
  U2 = Rm/((Rg+Ri)^2-Rm^2));

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -120},{100,120}}), graphics));
end PreinsulatedPipes;
