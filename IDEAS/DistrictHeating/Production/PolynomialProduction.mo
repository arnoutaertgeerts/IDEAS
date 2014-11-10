within IDEAS.DistrictHeating.Production;
model PolynomialProduction
  "Production model based on a polynomial function derived from performance data"

  //Extensions
  extends IDEAS.DistrictHeating.Production.BaseClasses.PartialHeater(
      QNomRef=data.QNomRef,
      etaRef=data.etaRef,
      TMax=data.TMax,
      TMin=data.TMin,
      modulationMin=data.modulationMin,
      modulationStart=data.modulationStart,
      redeclare HeatSources.Polynomial heatSource(
        redeclare package Medium = Medium,
        beta=beta,
        powers=powers));

  //Parameters
  parameter Real beta[10];
  parameter Integer powers[10,4];

equation
  PEl = 7 + heatSource.modulation/100*(33 - 7);
  PFuel = heatSource.PFuel;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,120}}), graphics={Line(
          points={{-100,0},{-86,42},{-70,0},{-52,-42},{-40,0}},
          color={0,0,255},
          smooth=Smooth.Bezier), Line(
          points={{-40,0},{-22,0}},
          color={0,0,255},
          smooth=Smooth.Bezier)}));
end PolynomialProduction;
